import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/pages/payment_page.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_card_menu_item.dart';

import '../../cubit/menu_cubit.dart';
import '../../models/menu_model.dart';
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
    context.read<MenuCubit>().getMenus();
    super.initState();
  }

  Box<MenuModel> localDBBox = Hive.box<MenuModel>('shopping_box');

  int i = 0;
  String dropdownvalue = 'Table Number';
  // List of items in our dropdown menu
  var items = [
    for (int i = 1; i <= 30; i++) i.toString(),
  ];

  int calcTotalPrice() {
    int sum = 0;
    for (int i = 0; i < localDBBox.length; i++) {
      var cartModel = localDBBox.getAt(i) as MenuModel;
      int iprice = cartModel.price * cartModel.quantity;
      sum += iprice;
      print(sum);
      print('------');
      // print(_shoppingBoxLength);
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

  //* ORDER CARD WIDGET
  @override
  Widget orderCard(MenuModel menuModel) {
    //loop through the localDBBox

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
                            //set quantity to 1
                            // resetQty(menuModel);
                            // print('iqty: $iQty');
                            // print
                            //     'quantity di menumodel: ${menuModel.quantity}');

                            // localDBBox.deleteAt(getIndexHive(menuModel));
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
                height: 10,
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
                          print(selected);
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
                visible: true,
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
                        Center(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              menuMaxHeight: 150,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: primaryColor,
                              ),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                  print('dropdownvalue ${dropdownvalue}');
                                });
                              },
                              // isExpanded: true,
                              underline: Container(
                                height: 1,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        //* Location
                        Center(
                          child: Text(
                            'Location: Indoor',
                            style: greenTextStyle.copyWith(
                              fontWeight: medium,
                              fontSize: 15,
                            )
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

              Container(
                padding: const EdgeInsets.all(20),
                child: CustomButton(
                  title: 'Pay Now',
                  onPressed: () {
                    if (paymentController.selectedItem == 'qris') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentPage(totalPrice: calcTotalPrice()),
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, '/cashier');
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
