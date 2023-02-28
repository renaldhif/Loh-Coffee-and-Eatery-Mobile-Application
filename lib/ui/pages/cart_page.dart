import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';
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
  GroupController paymentController = GroupController(isMultipleSelection: false);
  GroupController diningController = GroupController(isMultipleSelection: false);

  @override
  void initState() {
    context.read<MenuCubit>().getMenus();
    super.initState();
  }

  Widget menuCard(List<MenuModel> menus) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: menus.map((MenuModel menu) {
          return CustomCardMenuItem(menu);
        }).toList(),
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
                      'Your Cart',
                      style: greenTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: black,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Menu List
                    //! Testing Purposes Only!
                    //TODO: Remember to change into cart data
                    BlocConsumer<MenuCubit, MenuState>(
                        listener: (context, state) {
                      if (state is MenuFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error),
                          ),
                        );
                      }
                    }, builder: (context, state) {
                      if (state is MenuSuccess) {
                        return menuCard(state.menus);
                      } else {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }
                    }),
                  ],
                ),
              ),

              // Container for Payment Option
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

              const SizedBox(height: 10,),

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
                        'Rp. 100.000',
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
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/login', (route) => false);
                    if (paymentController.selectedItem == 'qris'){
                      Navigator.pushNamed(context, '/payment');
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