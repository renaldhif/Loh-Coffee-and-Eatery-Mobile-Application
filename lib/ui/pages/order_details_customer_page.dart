import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loh_coffee_eatery/cubit/auth_cubit.dart';
import 'package:loh_coffee_eatery/models/order_model.dart';
import 'package:loh_coffee_eatery/models/review_model.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_rating_card.dart';
import '../../cubit/order_cubit.dart';
import '../../cubit/payment_cubit.dart';
import '../../cubit/review_cubit.dart';
import '../../models/menu_model.dart';
import '../../models/payment_model.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_button_red.dart';

class OrderDetailsCustomerPage extends StatefulWidget {
  int? orderNumber;
  OrderDetailsCustomerPage({super.key, this.orderNumber});

  @override
  State<OrderDetailsCustomerPage> createState() => _OrderDetailsCustomerPageState();
}

class _OrderDetailsCustomerPageState extends State<OrderDetailsCustomerPage> {
  @override
  void initState() {
    super.initState();
  }

  final CollectionReference<Map<String, dynamic>> orderList =
    FirebaseFirestore.instance.collection('orders');

  final CollectionReference<Map<String, dynamic>> paymentList =
      FirebaseFirestore.instance.collection('payments');

  final CollectionReference<Map<String, dynamic>> menuList =
      FirebaseFirestore.instance.collection('menus');
  
  final CollectionReference<Map<String, dynamic>> userList =
      FirebaseFirestore.instance.collection('users');

  
  List<OrderModel> orderModelList = [];
  List<MenuModel> listMenu = [];


Future<String> getCurrentUserEmail() async {
  if (FirebaseAuth.instance.currentUser != null) {
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userNow = await context
        .read<AuthCubit>()
        .getCurrentUser(user!.uid);
    String? email = userNow.email;
    print('Current User Email: $email');
    return email.toString();
  } else {
    throw Exception('User is not logged in');
  }
}

//get order model by id without using cubit
Future<OrderModel> getOrderModelById(String orderID) async {
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await orderList.doc(orderID).get();
  OrderModel orderModel = OrderModel.fromJson(documentSnapshot.id, documentSnapshot.data() as Map<String, dynamic>);
  return orderModel;
}


  //
  void addOrderModelToList() async {
    String email = await getCurrentUserEmail();
    List<String> orderIDList =
      await context.read<OrderCubit>().getOrderIdListByUserEmail(email);
    
    for(int i = 0; i < orderIDList.length; i++){
      OrderModel orderModel = await getOrderModelById(orderIDList[i]);
      orderModelList.add(orderModel);
      }
    
  }

  Future<int> getOrderModelListLength() async {
    return orderModelList.length;
  }

  //------------------

    //get order id by order number
  Future<String> getOrderIdByOrderNumber(int orderNumber) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await orderList
        .where('number', isEqualTo: orderNumber)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      String id = querySnapshot.docs.first.id;
      return id;
    } else {
      throw Exception("No order found with order number $orderNumber");
    }
  }

  //get order timestamp by order number
  Future<Timestamp> getOrderTimestampByOrderNumber(int orderNumber) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await orderList
        .where('number', isEqualTo: orderNumber)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      Timestamp timestamp = querySnapshot.docs.first.data()['orderDateTime'];
      return timestamp;
    } else {
      throw Exception("No order found with order number $orderNumber");
    }
  }

  //get payment by timestamp in payment cubit
  Future<PaymentModel> getPaymentByTimestamp(Timestamp timestamp) async {
    PaymentModel payment = await context
        .read<PaymentCubit>()
        .getPaymentByTimestamp(paymentDateTime: timestamp);
    
    return payment;
  }

  Future<String> formatTime(PaymentModel payment) async {
    Timestamp time = payment.paymentDateTime;
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
    DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    String formattedTime = dateFormat.format(dateTime);

    return formattedTime;
  }

  //get customer name by order number
  Future<String> getCustomerNameByOrderNumber(int orderNumber) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    Timestamp timestamp = await getOrderTimestampByOrderNumber(orderNumber);
    PaymentModel payment = await getPaymentByTimestamp(timestamp);
    String customerName = payment.customerName;
    // print('Customer Name ini: $customerName');
    // print('Order ID: $orderId');
    return customerName;
  }

  //get table number by order number
  Future<int> getTableNumberByOrderNumber(int orderNumber) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await orderList.doc(orderId).get();
    int tableNumber = documentSnapshot.data()!['tableNum'];
    // print('Table Number: $tableNumber');
    return tableNumber;
  }

  //get order status by order number
  Future<String> getOrderStatusByOrderNumber(int orderNumber) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await orderList.doc(orderId).get();
    String orderStatus = documentSnapshot.data()!['orderStatus'];
    // print('Order Status: $orderStatus');
    return orderStatus;
  }

  //get list of menu id by order number
  Future<List<String>> getMenuIdByOrderNumber(int orderNumber) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await orderList.doc(orderId).get();
    List<dynamic> menuListHere = documentSnapshot.data()!['menu'];
    List<String> menuIdList = [];

    for (int i = 0; i < menuListHere.length; i++) {
      String menuTitle = menuListHere[i]['title'];

      //get menuModel by comparing menuTitle with menuList
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await menuList
          .where('title', isEqualTo: menuTitle)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String menuId = querySnapshot.docs.first.id;
        menuIdList.add(menuId);
      } else {
        throw Exception("No menu found with title $menuTitle");
      }
    }
    // print('Menu ID List: $menuIdList');
    return menuIdList;
  }

  //get list of MenuModel by order number
  Future<List<MenuModel>> getMenuByOrderNumber(int orderNumber) async {
    List<String> menuIdList = await getMenuIdByOrderNumber(orderNumber);
    List<MenuModel> menuModelList = [];

    for (int i = 0; i < menuIdList.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await menuList.doc(menuIdList[i]).get();
            Map<String, dynamic> data = documentSnapshot.data()!;
      MenuModel menuModel = MenuModel(
        id: documentSnapshot.id,
        title: data['title'],
        description: data['description'],
        tag: data['tag'],
        price: data['price'],
        image: data['image'],
        totalLoved: data['totalLoved'],
        totalOrdered: data['totalOrdered'],
        userId: List<String>.from(data['userId']),
        quantity: data['quantity'],
      );
      menuModelList.add(menuModel);
      listMenu.add(menuModel);
    }
    // print('Menu Model List: $menuModelList');
    return menuModelList;
  }

  //get user id by order number
  Future<String> getUserIdByOrderNumber(int orderNumber) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await orderList.doc(orderId).get();
    String userEmail = documentSnapshot.data()!['user']['email'];
    
    //get user document by comparing userName with userList
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await userList
          .where('email', isEqualTo: userEmail)
          .get();
    if (querySnapshot.docs.isNotEmpty) {
      String userId = querySnapshot.docs.first.id;
      // print('User ID: $userId');
      return userId;
    } else {
      throw Exception("No user found with name $userEmail");
    }
  }

  //get dining option by paymentmodel
  Future<String> getDiningOptionByPaymentModel(PaymentModel payment) async {
    String diningOption = payment.diningOption;
    // print('Dining Option: $diningOption');
    return diningOption;
  }

  //get total price by paymentmodel
  Future<int> getTotalPriceByPaymentModel(PaymentModel payment) async {
    int totalPrice = payment.totalPrice;
    // print('Total Price: $totalPrice');
    return totalPrice;
  }

  //get payment status by paymentmodel
    Future<String> getPaymentStatusByPaymentModel(PaymentModel payment) async {
    String status = payment.status;
    // print('Total Price: $totalPrice');
    return status;
  }

  Future<int> listMenuLength() async {
    return listMenu.length;
  }

  //get list of menuModel in orderList by orderNumber
  Future<List<MenuModel>> getMenuList2(int orderNumber) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await orderList.doc(orderId).get();
    List<MenuModel> menu = documentSnapshot.data()!['menu'];
    return menu;
  }

  //get menu quantity by index
  Future<int> getMenuQuantityByOrderNumber(int orderNumber, int index) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await orderList.doc(orderId).get();
    List<dynamic> menuListHere = documentSnapshot.data()!['menu'];
    int menuQuantity = menuListHere[index]['quantity'];

    return menuQuantity;
  }

    Future<int> getMenuPriceByOrderNumber(int orderNumber, int index) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await orderList.doc(orderId).get();
    List<dynamic> menuListHere = documentSnapshot.data()!['menu'];
    int menuPrice = menuListHere[index]['price'];

    return menuPrice;
  }

    Future<String> getMenuImageByOrderNumber(int orderNumber, int index) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await orderList.doc(orderId).get();
    List<dynamic> menuListHere = documentSnapshot.data()!['menu'];
    String menuImage = menuListHere[index]['image'];

    return menuImage;
  }

  

  //method to get menus by lopping through listMenu length and call orderContent
  Widget getMenus() {
    return FutureBuilder<int>(
      future: listMenuLength(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //call paymentHeader without using ListView.builder
          return Column(
            children: [
              for (int i = 0; i < snapshot.data!; i++)
                FutureBuilder<Widget>(
                  future: orderContent(i),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: 0.8 * MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            children: [
                              snapshot.data!,
                            ],
                          ),
                        )
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
            ],
          );
        } else {
          //return no payments
          return const Center(
            child: Text('No Orders'),
          );
        }
      },
    );
  }
  

  bool isConfirm = false;
  String diningOption = 'Dine In';
  String paymentStatus = 'Payment confirmed';
  String orderStatus = 'Order confirmed';

  Future<Widget> orderContent(int index) async {
    String name = listMenu[index].title;
    int qty = await getMenuQuantityByOrderNumber(widget.orderNumber!, index);
    Timestamp orderTime = await getOrderTimestampByOrderNumber(widget.orderNumber!);
    PaymentModel payment = await getPaymentByTimestamp(orderTime);
    String orderNumber = widget.orderNumber.toString();
    List<MenuModel> menuList2 = await getMenuByOrderNumber(widget.orderNumber!);
    int price = await getMenuPriceByOrderNumber(widget.orderNumber!, index);
    String image = await getMenuImageByOrderNumber(widget.orderNumber!, index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 0.2 * MediaQuery.of(context).size.width,
              width: 0.2 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  //! Change to Image.network
                  child: Image.network(
                    image,
                    width: 0.2 * MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menu Name
                Text(
                  //getOrderName(),
                  // iName,
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: greenTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: black,
                  ),
                ),
                const SizedBox(height: 5),

                // Menu Price
                Row(
                  children: [
                    Text(
                      'Rp',
                      style: orangeTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: extraBold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      // iPrice.toString(),
                      price.toString(),
                      style: orangeTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: extraBold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // Quantity
                Text(
                  'Qty: 1',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: greenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<Widget> orderDetailCard() async {
    String orderNumber = widget.orderNumber.toString();
    String customerName = await getCustomerNameByOrderNumber(widget.orderNumber!);
    Timestamp orderTime = await getOrderTimestampByOrderNumber(widget.orderNumber!);
    PaymentModel payment = await getPaymentByTimestamp(orderTime);
    String diningOption = await getDiningOptionByPaymentModel(payment);
    int tableNumber = await getTableNumberByOrderNumber(widget.orderNumber!);
    int totalPrice = await getTotalPriceByPaymentModel(payment);
    String orderStatus = await getOrderStatusByOrderNumber(widget.orderNumber!);
    String paymentStatus = await getPaymentStatusByPaymentModel(payment);
    List<MenuModel> menuList2 = await getMenuByOrderNumber(widget.orderNumber!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

      // spacer line
        const SizedBox(height: 5),
        Container(
          width: 0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),
        const SizedBox(height: 10),

        Text(
          'Order Number: $orderNumber',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: greenTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),

        // spacer line
        const SizedBox(height: 15),
        Container(
          width: 0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),
        const SizedBox(height: 10),



        //* Customer Name
        Text(
          'Customer Name: $customerName',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: greenTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
        
        const SizedBox(height: 10),

        // spacer line
        const SizedBox(height: 5),
        Container(
          width: 0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),
        const SizedBox(height: 10),

        //* Order Details
        Text(
          'Dining Option: $diningOption',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: greenTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
        const SizedBox(height: 10),
        //* Table Number
        Visibility(
          visible:
              diningOption == 'Dine In' ? true : false,
          child: Text(
            'Table Number: $tableNumber',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: greenTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),

          ),
        ),
        const SizedBox(height: 5),

        // spacer line
        const SizedBox(height: 5),
        Container(
          width:
              0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),
        //* Order Content
        getMenus(),
        // orderContent(),

        // spacer line
        Container(
          width:
              0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),

        //* TOTAL PRICE
        const SizedBox(height: 10),
        Text(
          'Total Price:',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: greenTextStyle.copyWith(
            fontSize: 16,
            fontWeight: black,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rp',
              style: orangeTextStyle.copyWith(
                fontSize: 16,
                fontWeight: extraBold,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              // iPrice.toString(),
              totalPrice.toString(),
              style: orangeTextStyle.copyWith(
                fontSize: 16,
                fontWeight: extraBold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // spacer line
        const SizedBox(height: 5),
        Container(
          width:
              0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),
        const SizedBox(height: 10),

        //* Payment Status
        Text(
          'Payment Status:',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: greenTextStyle.copyWith(
            fontSize: 16,
            fontWeight: black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '$paymentStatus',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: greenTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const SizedBox(height: 10),

        //* order Status
        Text(
          'Order Status:',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: greenTextStyle.copyWith(
            fontSize: 16,
            fontWeight: black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '$orderStatus',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: orderStatus == 'Order confirmed'
              ? greenTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                )
              : orangeTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
        ),
        const SizedBox(height: 10),
        // spacer line
        const SizedBox(height: 5),
        Container(
          width:
              0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: whiteColor,
          width: double.infinity,
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Your Order🍽',
                        style: greenTextStyle.copyWith(
                          fontSize: 28,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ), // Header End
              //* Order Cards
             FutureBuilder<Widget>(
                future: orderDetailCard(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data as Widget;
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // Handle other cases
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}