import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loh_coffee_eatery/cubit/menu_cubit.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_card_menu_item.dart';
import '../../models/menu_model.dart';

class HomePageRecommend extends StatefulWidget {
  const HomePageRecommend({super.key});

  @override
  State<HomePageRecommend> createState() => _HomePageRecommendState();
}

class _HomePageRecommendState extends State<HomePageRecommend> {
  Box<MenuModel> _shoppingBox = Hive.box('shopping_box');

  // To change the selected value of bottom navigation bar
  int _selectedIndex = 0;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        // case 1:
        //   Navigator.pushNamed(context, '/addmenu');
        //   break;
        case 2:
          Navigator.pushNamed(context, '/orderlist');
          break;
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

  late String currentUid;
  final _auth = FirebaseAuth.instance;

  void getCurrentUserUid() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      setState(() {
        currentUid = currentUser.uid;
      });
    }
  }

  @override
  void initState() {
    getCurrentUserUid();
    context.read<MenuCubit>().getRecommendedMenus(currentUid);
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

  Widget menuCardRecommended(List<MenuModel> menuRecommended) {
    //* Backup
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: menuRecommended.map((MenuModel menu) {
          return CustomCardMenuItem(menu);
        }).toList(),
      ),
    );

    // print('menuRecommended length: ${menuRecommended.length}');
    // if (menuRecommended.isEmpty) {
    //   return const Padding(
    //     padding: EdgeInsets.all(24),
    //     child: Text(
    //       'We are sorry, we cannot provide the recommendation menu due to your menu preferences do not match with our recommendation menu.\n\n However, we still provide you with our recommended menu list.',
    //       textAlign: TextAlign.center,
    //     ),
    //   );
    // } else {
    //   return Container(
    //     margin: const EdgeInsets.symmetric(
    //       horizontal: 20,
    //     ),
    //     width: double.infinity,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: menuRecommended.map((MenuModel menu) {
    //         return CustomCardMenuItem(menu);
    //       }).toList(),
    //     ),
    //   );
    // }
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
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      icon: const Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: Text(
                        'Our Recommendation Menu',
                        style: greenTextStyle.copyWith(
                          fontSize: 22,
                          fontWeight: black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  BlocBuilder<MenuCubit, MenuState>(
                    builder: (context, state) {
                      if (state is MenuSuccessRecomendation) {
                        return Column(
                          children: [
                            Visibility(
                              visible: state.menuRecommend.isEmpty,
                              child: const Padding(
                                padding: EdgeInsets.all(24),
                                child: Text(
                                  'We are sorry, we cannot provide the recommendation menu due to your menu preferences do not match with our recommendation menu.\n\n To get our recommended menu, you can either update your menu preferences or empty the your menu preferences.\n\nThank you.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            menuCardRecommended(state.menuRecommend),
                          ],
                        );
                      } else if (state is MenuFailed) {
                        return Center(
                          child: Text(state.error),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 80),
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
        backgroundColor: primaryColor,
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
            icon: Icon(Icons.local_post_office_sharp),
            label: 'Promo',
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