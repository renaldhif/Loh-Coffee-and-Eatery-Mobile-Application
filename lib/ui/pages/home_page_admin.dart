import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
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
        case 4:
          Navigator.pushNamed(context, '/addpromo');
          break;
        case 5:
          Navigator.pushNamed(context, '/profile-admin');
          break;
      }
    });
  }

  @override
  void initState() {
    initializeTheme(false);
    context.read<MenuCubit>().getMenus();
    super.initState();

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
    final user = FirebaseAuth.instance.currentUser;
    Box<bool> isLanguageEnglishBox = Hive.box<bool>('isLanguageEnglishBox_${user!.uid}');
    //call the EasyLocalization based on the hiveBox
    bool _isSwitched = isLanguageEnglishBox.get('isLanguageEnglish') ?? false;
    EasyLocalization.of(context)!
    .setLocale(_isSwitched ? Locale('id', 'ID') : Locale('en', 'US'));
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
                        'welcome_admin'.tr(),
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
                  return Center(
                    child: Text("something_wrong".tr()),
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
        label: Text('add_menu'.tr()),
        icon: const Icon(Icons.add),
        backgroundColor: greenButtonColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "nav_home".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: "nav_reservations".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_rounded),
            label: "nav_orders".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: "nav_payments".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded),
            label: "nav_posts".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "nav_profile".tr(),
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
