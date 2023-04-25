import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loh_coffee_eatery/cubit/menu_cubit.dart';
import 'package:loh_coffee_eatery/cubit/order_cubit.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import 'package:loh_coffee_eatery/models/payment_model.dart';
import '../../cubit/order_state.dart';
import '../../cubit/payment_cubit.dart';
import '../../cubit/payment_state.dart';
import '../../cubit/table_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_button_red.dart';
import '/shared/theme.dart';

class OrderDetailsPage extends StatefulWidget {
  int? orderNumber;

  OrderDetailsPage({super.key, this.orderNumber});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    // context.read<OrderCubit>();
    super.initState();
  }

// String orderStatus = 'Pending';
//   String diningOption = 'Dine In';
//   String paymentStatus = 'Confirmed';
  // bool isOpen = false;
  List<MenuModel> listMenu = [];

  final CollectionReference<Map<String, dynamic>> orderList =
      FirebaseFirestore.instance.collection('orders');

  final CollectionReference<Map<String, dynamic>> paymentList =
      FirebaseFirestore.instance.collection('payments');

  final CollectionReference<Map<String, dynamic>> menuList =
      FirebaseFirestore.instance.collection('menus');

  final CollectionReference<Map<String, dynamic>> userList =
      FirebaseFirestore.instance.collection('users');

  //get order length
  Future<int> orderLength() async {
    AggregateQuerySnapshot query = await orderList.count().get();
    // print('The number of order: ${query.count}');
    return query.count;
  }

  //get order id by order number
  Future<String> getOrderIdByOrderNumber(int orderNumber) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await orderList.where('number', isEqualTo: orderNumber).get();
    if (querySnapshot.docs.isNotEmpty) {
      String id = querySnapshot.docs.first.id;
      return id;
    } else {
      throw Exception("No order found with order number $orderNumber");
    }
  }

  //get order timestamp by order number
  Future<Timestamp> getOrderTimestampByOrderNumber(int orderNumber) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await orderList.where('number', isEqualTo: orderNumber).get();
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
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await menuList.where('title', isEqualTo: menuTitle).get();
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
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await userList.where('email', isEqualTo: userEmail).get();
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

  List<MenuModel> listMenu2 = [];

  //get list of menuModel in orderList by orderNumber
  Future<List<MenuModel>> getMenuList2(int orderNumber) async {
    String orderId = await getOrderIdByOrderNumber(orderNumber);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await orderList.doc(orderId).get();
    List<MenuModel> menu = documentSnapshot.data()!['menu'];
    listMenu2 = menu;
    return menu;
  }

  //get lenght of list menu
  Future<int> listMenuLength() async {
    return listMenu2.length;
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

  //update totalOrdered in list menu based on order number
  Future<void> incrementTotalOrdered(
      int orderNumber, List<MenuModel> menu, int quantity) async {
    List<MenuModel> menu = await getMenuList2(orderNumber);
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
                          ));
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
          return Center(
            child: Text('no_order'.tr()),
          );
        }
      },
    );
  }

  bool isConfirm = false;

  Future<Widget> orderDetails() async {
    String orderNumber = widget.orderNumber.toString();
    String customerName =
        await getCustomerNameByOrderNumber(widget.orderNumber!);
    Timestamp orderTime =
        await getOrderTimestampByOrderNumber(widget.orderNumber!);
    PaymentModel payment = await getPaymentByTimestamp(orderTime);
    String diningOption = await getDiningOptionByPaymentModel(payment);
    int tableNumber = await getTableNumberByOrderNumber(widget.orderNumber!);
    int totalPrice = await getTotalPriceByPaymentModel(payment);
    String orderStatus = await getOrderStatusByOrderNumber(widget.orderNumber!);
    String paymentStatus = await getPaymentStatusByPaymentModel(payment);
    List<MenuModel> menuList2 = await getMenuByOrderNumber(widget.orderNumber!);

    if (orderStatus == 'Pending') {
      isConfirm = false;
    } else {
      isConfirm = true;
    }

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
          'order_number'.tr() + ' : $orderNumber',
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
          'customer_name'.tr() + ': $customerName',
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
          'dining_option'.tr() + ' : $diningOption',
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
          visible: diningOption == 'Dine In' ? true : false,
          child: Text(
            'table_number'.tr() + ': $tableNumber',
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
          width: 0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),
        //* Order Content
        getMenus(),

        // spacer line
        Container(
          width: 0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),

        //* TOTAL PRICE
        const SizedBox(height: 10),
        Text(
          'total_price'.tr() + ' :',
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
              '$totalPrice',
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
          width: 0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),
        const SizedBox(height: 10),

        //* Payment Status
        Text(
          'payment_status'.tr() + ':',
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
          'order_status'.tr() + ':',
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
          style: orderStatus == 'Confirmed'
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
          width: 0.8 * MediaQuery.of(context).size.width,
          height: 5,
          color: kUnavailableColor,
        ),

        const SizedBox(height: 15),
        //* Confirm order button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Visibility(
            visible: !isConfirm && paymentStatus == 'Confirmed',
            child: BlocConsumer<OrderCubit, OrderState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is OrderSuccess) {
                        print('order success');
                } else if (state is OrderFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                    title: "confirm".tr(),
                    onPressed: () {
                      

                      setState(() {
                        context.read<OrderCubit>().updateOrderStatusByNumber(
                            orderNumber: widget.orderNumber!,
                            orderStatus: 'Confirmed',
                          );
                      context
                          .read<OrderCubit>()
                          .updateTotalOrdered(widget.orderNumber!, menuList2);
                        isConfirm = true;
                        orderStatus = 'Confirmed';

                        // Navigator.pushReplacementNamed(context, '/home-admin');
                      });
                    });
              },
            ),
          ),
        ),
        const SizedBox(height: 15),

        //* Reject order button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Visibility(
            visible: !isConfirm && paymentStatus == 'Confirmed',
            child: CustomButtonRed(
              title: "reject".tr(),
              onPressed: () {
                context.read<OrderCubit>().updateOrderStatusByNumber(
                      orderNumber: widget.orderNumber!,
                      orderStatus: 'Rejected',
                    );
                setState(() {
                  isConfirm = true;
                  orderStatus = 'Rejected';
                  Navigator.pushReplacementNamed(context, '/home-admin');
                });
              },
            ),
          ),
        ),
        // order status
        const SizedBox(height: 15),
      ],
    );
  }

  Future<Widget> orderContent(int index) async {
    String name = listMenu[index].title;
    int qty = await getMenuQuantityByOrderNumber(widget.orderNumber!, index);
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        //* Order Name
        Text(
          '$name',
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
          'quantity'.tr() + ': $qty',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: greenTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  ],
                ),
              ),

              // The detail of the menu selected
              Text(
                'order_details'.tr(),
                style: greenTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: black,
                ),
              ),
              const SizedBox(height: 30),

              FutureBuilder<Widget>(
                future: orderDetails(),
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
