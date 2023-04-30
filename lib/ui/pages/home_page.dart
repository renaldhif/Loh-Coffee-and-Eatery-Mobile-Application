import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

//import 'package:hive_flutter/hive_flutter.dart';
//import hive adapter
import 'package:loh_coffee_eatery/cubit/menu_cubit.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_card_menu_item.dart';

import '../../models/menu_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<MenuModel> _shoppingBox = Hive.box('shopping_box');

  // To change the selected value of bottom navigation bar
  int _selectedIndex = 0;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 1:
          Navigator.pushNamed(context, '/reservation');
          break;
        case 2:
          Navigator.pushNamed(context, '/orderlist');
          break;
        case 3:
          Navigator.pushNamed(context, '/promo');
          break;
        case 4:
          Navigator.pushNamed(context, '/profilemenu');
          _selectedIndex = 0;
          break;
      }
    });
  }

  @override
  void initState() {
    context.read<MenuCubit>().getMenus();
    super.initState();
    initializeTheme(false);
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
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                margin: EdgeInsets.all(defaultRadius),
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      'welcome'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'want_to_try'.tr(),
                          style: greenTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pushReplacementNamed(
                                  context, '/home-recommend');
                            });
                          },
                          child: Center(
                            child: Text(
                              'click_here'.tr(),
                              style: orangeTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Menu List
              BlocConsumer<MenuCubit, MenuState>(listener: (context, state) {
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
                  print('state is menu success');
                  return menuCard(state.menus);
                } else {
                  return Center(
                    child: Text('something_wrong'.tr()),
                  );
                }
              }),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        label: Text(_shoppingBox.length.toString()),
        icon: const Icon(Icons.shopping_cart_rounded),
        backgroundColor: greenButtonColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'nav_home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'nav_reservations'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_rounded),
            label: 'nav_orders'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_post_office_sharp),
            label: 'nav_promo'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'nav_profile'.tr(),
          ),
        ],
        backgroundColor: whiteColor,
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
