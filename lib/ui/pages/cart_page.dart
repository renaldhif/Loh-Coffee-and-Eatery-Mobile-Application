import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/pages/payment_page.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/menu_cubit.dart';
import '../../cubit/order_cubit.dart';
import '../../cubit/payment_cubit.dart';
import '../../models/menu_model.dart';
import '../../models/order_model.dart';
import '../../models/payment_model.dart';
import '../../models/user_model.dart';
import '../widgets/custom_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // To change the selected value of bottom navigation bar
  int _selectedIndex = 0;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        // case 1:
        //   Navigator.pushNamed(context, '/addmenu');
        //   break;
        // case 2:
        //   Navigator.pushNamed(context, '/home-admin');
        //   break;
        // case 3:
        //   Navigator.pushNamed(context, '/notification');
        //   break;
        case 4:
          Navigator.pushNamed(context, '/profilemenu');
          _selectedIndex = 0;
          break;
      }
    });
  }

  //* Group Controller
  GroupController paymentController =
      GroupController(isMultipleSelection: false);
  GroupController diningController =
      GroupController(isMultipleSelection: false);

  @override
  void initState() {
    if (lenLocalDBBox < 1) isCartEmpty = true;
    context.read<MenuCubit>().getMenus();
    super.initState();
  }

  Box<MenuModel> localDBBox = Hive.box<MenuModel>('shopping_box');
  int lenLocalDBBox = Hive.box<MenuModel>('shopping_box').length;
  int i = 0;
  bool isCartEmpty = false;
  bool isDineIn = false;
  String dropdownvalue = '1';
  String tableLocation = '';
  String paymentOption = 'QRIS';
  String diningOption = 'Dine In';
  int tableChoosen = 1;

  final CollectionReference<Map<String, dynamic>> productList =
      FirebaseFirestore.instance.collection('tables');

  Future<int> tableLength() async {
    AggregateQuerySnapshot query = await productList.count().get();
    print('The number of table: ${query.count}');
    return query.count;
  }

  //get list of menuId in localDBBox
  List<String> getListMenuId() {
    List<String> listMenuId = [];
    for (int i = 0; i < localDBBox.length; i++) {
      var cartModel = localDBBox.getAt(i) as MenuModel;
      listMenuId.add(cartModel.id);
    }
    return listMenuId;
  }

//get tableNum
  Future<int> getTableNum(int index) async {
    QuerySnapshot<Map<String, dynamic>> query = await productList.get();
    print('The number of table: ${query.docs[index].data()['tableNum']}');
    return query.docs[index].data()['tableNum'];
  }

  //get table index based on tableNum
  Future<String> getTableIndex(int tableNum) async {
    QuerySnapshot<Map<String, dynamic>> query = await productList.get();
    int index = 0;
    for (int i = 0; i < query.docs.length; i++) {
      if (query.docs[i].data()['tableNum'] == tableNum) {
        index = i;
      }
    }
    print('The number of table: $index');

    tableLocation = query.docs[index].data()['location'];
    return tableLocation;
  }



  //get table location based on tableNum
  Future<String> getTableLocation(int tableNum) async {
    QuerySnapshot<Map<String, dynamic>> query = await productList.get();
    tableLocation = query.docs[tableNum].data()['location'];
    return tableLocation;
  }

  int calcTotalPrice() {
    int sum = 0;
    for (int i = 0; i < localDBBox.length; i++) {
      var cartModel = localDBBox.getAt(i) as MenuModel;
      int iprice = cartModel.price * cartModel.quantity;
      sum += iprice;
      print(sum);
      print('------');
    }

    return sum;
  }

  MenuModel getMenuModel(int index) {
    MenuModel menuModel = localDBBox.getAt(index) as MenuModel;
    return menuModel;
  }

  int getIndexHive(MenuModel menuModel) {
    int index = localDBBox.values.toList().indexOf(menuModel);
    return index;
  }

  //method add quantity in hive box
  void addQty(MenuModel menuModel) {
    int index = getIndexHive(menuModel);
    int qty = localDBBox.getAt(index)!.quantity;
    qty++;
    localDBBox.putAt(index, menuModel.copyWith(quantity: qty));
  }

  //method minus quantity in hive box
  void minusQty(MenuModel menuModel) {
    int index = getIndexHive(menuModel);
    int qty = localDBBox.getAt(index)!.quantity;
    qty--;
    localDBBox.putAt(index, menuModel.copyWith(quantity: qty));
  }

  void resetQty(MenuModel menuModel) {
    int index = getIndexHive(menuModel);
    int qty = localDBBox.getAt(index)!.quantity;
    qty = 1;
    localDBBox.putAt(index, menuModel.copyWith(quantity: qty));
  }

  Widget TextCartEmpty() {
    if(localDBBox.length < 1){
      isCartEmpty = true;
      return Visibility(
      visible: isCartEmpty,
      child: Text(
        'Your cart is empty. Please add some items.',
        style: greenTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
    );
    }
    return Container();
  }

  //* ORDER CARD WIDGET
  @override
  Widget orderCard(MenuModel menuModel) {
    String iName = '';
    int iPrice = 0;
    String iImage = '';

    //get the name of the menu with index
    iName =
        localDBBox.getAt(localDBBox.values.toList().indexOf(menuModel))!.title;
    //get the price of the menu with index
    iPrice =
        localDBBox.getAt(localDBBox.values.toList().indexOf(menuModel))!.price;
    //get the image of the menu with index
    iImage =
        localDBBox.getAt(localDBBox.values.toList().indexOf(menuModel))!.image;
    //get quantity of each menu
    int iQty = localDBBox
        .getAt(localDBBox.values.toList().indexOf(menuModel))!
        .quantity;
    //int qty = 1;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
      width: 0.9 * MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        border: Border.all(
          color: kUnavailableColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(1, 3),
          ),
        ],
        color: whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),

        // Menu Card Content
        child: Row(
          children: [
            // Image
            Container(
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
                  child: Image.network(
                    //loop through localDBBox
                    //getOrderImage(),
                    iImage,
                    width: 0.2 * MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Menu Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //getOrderName(),
                        iName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: black,
                        ),
                      ),
                      const SizedBox(height: 5),
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
                            iPrice.toString(),
                            style: orangeTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: extraBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Menu Card Button
                  Row(
                    children: [
                      // Add to Cart Button
                      Container(
                        width: 0.35 * MediaQuery.of(context).size.width,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: primaryColor,
                            width: 1,
                          ),
                          color: whiteColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //* Minus Button
                            GestureDetector(
                              child: const Icon(
                                Icons.remove,
                                color: primaryColor,
                              ),
                              onTap: () {
                                setState(() {
                                  ;
                                  if (iQty <= 1) {
                                    localDBBox
                                        .deleteAt(getIndexHive(menuModel));
                                  } else if (iQty > 1) {
                                    context
                                        .read<MenuCubit>()
                                        .minusQuantity(menuModel);
                                    minusQty(menuModel);
                                    print('iqty: $iQty');
                                    print(
                                        'quantity di menumodel: ${menuModel.quantity}');
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: 10),

                            //* Quantity
                            Text(
                              iQty.toString(),
                              style: greenTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: extraBold,
                              ),
                            ),
                            const SizedBox(width: 10),

                            //* Plus Button
                            GestureDetector(
                              child: const Icon(
                                Icons.add,
                                color: primaryColor,
                              ),
                              onTap: () {
                                setState(() {
                                  context
                                      .read<MenuCubit>()
                                      .addQuantity(menuModel);
                                  //update the quantity of the menu
                                  addQty(menuModel);
                                  print('iqty: $iQty');
                                  print(
                                      'quantity di menumodel: ${menuModel.quantity}');
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),

                      //* Delete Button
                      GestureDetector(
                        child: const Icon(
                          Icons.delete,
                          color: primaryColor,
                          size: 28,
                        ),
                        onTap: () {
                          setState(() {
                            if (lenLocalDBBox < 1) {
                              isCartEmpty = true;
                              TextCartEmpty();
                            }

                            if (iQty <= 1) {
                              localDBBox.deleteAt(getIndexHive(menuModel));
                            } else if (iQty > 1) {
                              resetQty(menuModel);
                              localDBBox.deleteAt(getIndexHive(menuModel));
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // bool isDineIn = false;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                margin: EdgeInsets.all(defaultRadius),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Cart 🛒',
                      style: greenTextStyle.copyWith(
                        fontSize: 28,
                        fontWeight: black,
                      ),
                    ),
                    const SizedBox(height: 15),

                    //* Order Cart List
                    for (int x = 0; x < localDBBox.length; x++)
                      orderCard(getMenuModel(x)),
                  ],
                ),
              ),

              // Green spacer
              Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 5,
                color: primaryColor,
              ),

              const SizedBox(
                height: 20,
              ),

              //* Widget Cart Empty Text
              TextCartEmpty(),

              const SizedBox(
                height: 20,
              ),

              //* Container for Payment Option
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 3,
                ),
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(
                    color: kUnavailableColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(1, 3),
                    ),
                  ],
                  color: whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  // Menu Card Content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose your Payment Option',
                        style: greenTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SimpleGroupedCheckbox<String>(
                        controller: paymentController,
                        itemsTitle: const ["QRIS", "Pay to the Cashier"],
                        values: const ["qris", "cashier"],
                        groupStyle: GroupStyle(
                          activeColor: primaryColor,
                          itemTitleStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: semiBold,
                          ),
                        ),
                        checkFirstElement: true,
                        onItemSelected: (selected) => setState(() {
                          print(selected);
                          if(selected == 'qris'){
                            paymentOption = 'QRIS';
                            print('blok if payment opetion sleected: $paymentOption');
                          } else if(selected == 'cashier'){
                            paymentOption = 'Cashier';
                            print('blok elseif payment opetion sleected: $paymentOption');
                          }
                          print('--diluar--');
                          print('payment opetion sleected: $paymentOption');
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //* Container for Dining Option
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 3,
                ),
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(
                    color: kUnavailableColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(1, 3),
                    ),
                  ],
                  color: whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  // Menu Card Content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dining Option',
                        style: greenTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SimpleGroupedCheckbox<String>(
                        controller: diningController,
                        itemsTitle: const ["Dine in", "Takeaway"],
                        values: const ["dinein", "takeaway"],
                        groupStyle: GroupStyle(
                          activeColor: primaryColor,
                          itemTitleStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: semiBold,
                          ),
                        ),
                        checkFirstElement: true,
                        onItemSelected: (selected) => setState(() {
                          isDineIn = selected == 'takeaway' ? true : false;
                          print(selected);
                          print('isTakeAway?: ${isDineIn}');
                          if(selected == 'dinein'){
                            diningOption = 'Dine In';
                            print('blok if dining opetion sleected: $diningOption');
                          } else if(selected == 'takeaway'){
                            diningOption = 'Takeaway';
                            print('blok elseif dining opetion sleected: $diningOption');
                          }
                          print('dining opetion sleected: $diningOption');
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //* Container for Table Number
              Visibility(
                visible: !isDineIn,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 3,
                  ),
                  width: 0.9 * MediaQuery.of(context).size.width,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    border: Border.all(
                      color: kUnavailableColor,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(1, 3),
                      ),
                    ],
                    color: whiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    // Menu Card Content
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose your Table Number',
                          style: greenTextStyle.copyWith(
                            fontWeight: bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 30),

                        //* Dropdown table number
                        FutureBuilder<int>(
                          future: tableLength(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: 0.8 * MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: ButtonTheme(
                                    alignedDropdown: true,

                                    //* Dropdown
                                    child: DropdownButton(
                                      // value: dropdownvalue,
                                      hint: Text(
                                        dropdownvalue,
                                        style: greenTextStyle.copyWith(
                                          fontWeight: semiBold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      menuMaxHeight: 150,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: primaryColor,
                                      ),
                                      items: List.generate(snapshot.data!,
                                          (index) {
                                        return DropdownMenuItem(
                                          value: index + 1,
                                          child: Text((index + 1).toString()),
                                        );
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!.toString();
                                          print(
                                              'dropdownvalue ${dropdownvalue}');
                                        });
                                        tableChoosen = newValue!;
                                      },
                                      // isExpanded: true,
                                      underline: Container(
                                        height: 1,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 20),

                        //* Location
                        FutureBuilder<String>(
                          future: getTableIndex(int.parse(dropdownvalue)),
                          builder: (context, snapshot) => Center(
                            child: Text(
                              'Location: ${snapshot.hasData ? snapshot.data! : 'Loading...'}',
                              style: greenTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //* Container for Total Price
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 3,
                ),
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(
                    color: kUnavailableColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(1, 3),
                    ),
                  ],
                  color: whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  // Menu Card Content
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: greenTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        // 'Rp. 100.000',
                        calcTotalPrice().toString(),
                        // 'Rp. ${totalPrice.toString()}',
                        style: greenTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (calcTotalPrice() > 0)
                Container(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                    title: 'Pay Now',
                    onPressed: () async {
                      
                      if (FirebaseAuth.instance.currentUser != null) {
                                User? user = FirebaseAuth.instance.currentUser;
                                // Future<UserModel> userNow = context
                                //     .read<AuthCubit>()
                                //     .getCurrentUser(user!.uid)
                                UserModel userNow = await context
                                    .read<AuthCubit>()
                                    .getCurrentUser(user!.uid);
                                String? name = userNow.name;
                      
                      if (paymentController.selectedItem == 'qris') {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PaymentPage(paymentOption: paymentOption, 
                                diningOption: diningOption,
                                totalPrice: calcTotalPrice(),
                                tableNumber: tableChoosen),
                          ),
                        );
                      } else if(paymentController.selectedItem == 'cashier') {
                        Timestamp now = Timestamp.now();
                        int num = await orderLength();
                        context.read<PaymentCubit>().addPayment(
                                paymentReceipt: 'none',
                                paymentOption: paymentOption,
                                diningOption: diningOption,
                                totalPrice: calcTotalPrice(),
                                status: 'Pending',
                                paymentDateTime: now,
                                customerName: name,);
                          
                          PaymentModel payment = await context.read<PaymentCubit>().getPaymentByTimestamp(
                              paymentDateTime: now);
                          // OrderModel order1;
                          if(isDineIn){
                            // order1 = OrderModel(
                            //   number: num + 1,
                            //   user: userNow,
                            //   menu: localDBBox.values.toList(),
                            //   tableNum: tableChoosen,
                            //   payment: payment,
                            //   orderStatus: 'Pending',
                            //   orderDateTime: now,
                            // );}
                            context.read<OrderCubit>().createOrder(
                              number: num + 1,
                              user: userNow,
                              menu: localDBBox.values.toList(),
                              tableNum: tableChoosen,
                              payment: payment,
                              orderStatus: 'Pending',
                              orderDateTime: now,
                            );
                            }

                          else{
                            context.read<OrderCubit>().createOrder(
                              number: num + 1,
                              user: userNow,
                              menu: localDBBox.values.toList(),
                              tableNum: 0,
                              payment: payment,
                              orderStatus: 'Pending',
                              orderDateTime: now,
                            );
                          }

                        localDBBox.clear();
                        Navigator.pushNamed(context, '/cashier');
                          }
                      
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Reserve',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_rounded),
            label: 'Order List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_rounded),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        showUnselectedLabels: true,
        onTap: _changeSelectedIndex,
      ),
    );
  }
}