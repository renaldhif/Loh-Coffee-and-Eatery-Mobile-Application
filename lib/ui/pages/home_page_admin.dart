import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/cubit/menu_cubit.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_card_menu_item_admin.dart';

import '../../models/menu_model.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {

  // To change the selected value of bottom navigation bar
  int _selectedIndex = 0;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          // Navigator.pushReplacementNamed(context, '/home-admin');
          _selectedIndex = 0;
          break;
        case 1:
          Navigator.pushNamed(context, '/reservation-admin');
          break;
        case 2:
          Navigator.pushNamed(context, '/orderlist-admin');
          break;
        case 3:
          Navigator.pushNamed(context, '/payment-admin');
          break;
        // case 4:
        //   break;
        case 5:
          Navigator.pushNamed(context, '/profile-admin');
          // _selectedIndex = 0;
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
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: menus.map((MenuModel menu) {
          return CustomCardMenuItemAdmin(menu);
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // Header
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Welcome, Loh Administrator!',
                        style: greenTextStyle.copyWith(
                          fontSize: 22,
                          fontWeight: black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Menu List
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

              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/addmenu');
        },
        label: const Text('Add Menu'),
        icon: const Icon(Icons.add),
        backgroundColor: greenButtonColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Reserves',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_rounded),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
