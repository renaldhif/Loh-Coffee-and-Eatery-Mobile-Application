import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loh_coffee_eatery/cubit/auth_cubit.dart';
import 'package:loh_coffee_eatery/cubit/theme_cubit.dart';
import '../../cubit/theme_state.dart';
import '../../models/user_model.dart';
import '/ui/widgets/custom_button_red.dart';
import '/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileMenuAdminPage extends StatefulWidget {
  const ProfileMenuAdminPage({super.key});

  @override
  State<ProfileMenuAdminPage> createState() => _ProfileMenuAdminPageState();

}

class _ProfileMenuAdminPageState extends State<ProfileMenuAdminPage> {

  void initState() {
    super.initState();
    initializeTheme(false); 
// Call the initializeTheme function here
  }
  //open hive box for dark mode
  // Box<bool> isDarkModeBox = Hive.box<bool>('isDarkModeBox');
  // // boolean for dark mode by getting the value from hive box
  // bool _isDarkMode = Hive.box<bool>('isDarkModeBox').get('isDarkMode') ?? false;

  // boolean for switch language

  // To change the selected value of bottom navigation bar
  int _selectedIndex = 5;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home-admin');
          _selectedIndex = 0;
          break;
        // case 1:
        //   Navigator.pushNamed(context, '/addmenu');
        //   break;
        case 2:
          Navigator.pushNamed(context, '/orderlist-admin');
          _selectedIndex = 2;
          break;
        case 3:
          Navigator.pushNamed(context, '/payment-admin');
          _selectedIndex = 3;
          break;
        // case 4:
        //   break;
        case 5:
          Navigator.pushNamed(context, '/profile-admin');
          _selectedIndex = 5;
          // _selectedIndex = 0;
          break;
      }
    });
  }

  String LocalizedText(String key) {
    return tr(key);
  }

  Widget signOutButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
            ),
          );
        } else if (state is AuthInitial) {
          // var userId = FirebaseAuth.instance.currentUser!.uid;
          // Hive.box('isDarkModeBox_$userId').close();
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false); 
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButtonRed(
              title: "sign_out".tr(),
              onPressed: () {
                context.read<AuthCubit>().signOut();
              }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Box<bool> isLanguageEnglishBox =
        Hive.box<bool>('isLanguageEnglishBox_${user!.uid}');
    bool _isSwitched =
        isLanguageEnglishBox.get('isLanguageEnglish') ?? false;
        
  Box<bool> isDarkModeBox = Hive.box<bool>('isDarkModeBox_${user!.uid}');
  bool _isDarkMode = isDarkModeBox.get('isDarkMode') ?? false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: kUnavailableColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: whiteColor,
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
                        "profile_menu",
                        style: greenTextStyle.copyWith(
                          fontSize: 40,
                          fontWeight: bold,
                        ),
                      ).tr(),
                    ),
                  ],
                ),
              ),
              // profile detail
              const SizedBox(height: 15),

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: false,
          body: Container(
            color: backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: backgroundColor,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon:  Icon(
                            Icons.arrow_circle_left_rounded,
                            color: primaryColor,
                            size: 55,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            'Profile Menu',
                            style: greenTextStyle.copyWith(
                              fontSize: 40,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // profile detail
                  const SizedBox(height: 15),

                  // profile card
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: backgroundColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: primaryColor,
                              child: CircleAvatar(
                                backgroundImage:
                                    Image.asset('assets/images/lohlogo.jpeg')
                                        .image,
                                radius: 29, //size
                                backgroundColor: primaryColor,
                              ),
                            ),
                            const SizedBox(width: 20),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                if (state is AuthSuccess) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${state.user.name}',
                                        style: mainTextStyle.copyWith(
                                          fontSize: 20,
                                          fontWeight: bold,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 5),
                                      ),
                                      Text(
                                        '${state.user.email}',
                                        style: mainTextStyle.copyWith(
                                          fontSize: 15,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ],
                                  );
                                } else {}
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Reviews
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: Text(
                      'Table Management',
                      style: greenTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    
                     // Reviews
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  "table_management",
                  style: greenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.left,
                ).tr(),
              ),
                  ),
                  // Add Table
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: backgroundColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Icon(
                              Icons.table_restaurant,
                              size: 26,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "add_table",
                              style: greenTextStyle.copyWith(
                                fontSize: 17,
                                fontWeight: bold,
                              ),
                              textAlign: TextAlign.start,
                            ).tr(),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/addtable');
                          },
                          icon:  Icon(
                            Icons.arrow_forward,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Delete Table
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: backgroundColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Icon(
                              Icons.highlight_remove,
                              size: 26,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 20),
                            Text(
                            "delete_table",
                            style: greenTextStyle.copyWith(
                              fontSize: 17,
                              fontWeight: bold,
                            ),
                            textAlign: TextAlign.start,
                            ).tr(),
                          ],
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/deletetable');
                          },
                          icon:  Icon(
                            Icons.arrow_forward,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Reviews
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: Text(
                      "review_ratings",
                      style: greenTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                      textAlign: TextAlign.left,
                    ).tr(),
                  ),  

                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: backgroundColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Icon(
                              Icons.reviews_rounded,
                              size: 26,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "view_reviews",
                              style: greenTextStyle.copyWith(
                                fontSize: 17,
                                fontWeight: bold,
                              ),
                              textAlign: TextAlign.start,
                            ).tr(),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/reviews');
                          },
                          icon:  Icon(
                            Icons.arrow_forward,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // General Setting title
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: Text(
                      "general_settings",
                      style: greenTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                      textAlign: TextAlign.left,
                    ).tr(),
                  ),
                  ],
                ),
              ),
                  // General Setting Content

                  // Dark Mode
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Icon(
                              Icons.dark_mode_rounded,
                              size: 26,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "dark_mode",
                              style: greenTextStyle.copyWith(
                                fontSize: 17,
                                fontWeight: bold,
                              ),
                              textAlign: TextAlign.start,
                            ).tr(),
                          ],
                        ),

                        Switch(
                          //TODO: Iteration 3: Implement Dark Mode
                          onChanged: (value) {
                            setState(() {
                              isDarkModeBox.put('isDarkMode', value);
                              initializeTheme(value);
                              _isDarkMode = value;
                              context.read<ThemeCubit>().toggleTheme();
                            });
                          },
                          value: _isDarkMode,
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ),

                  // Switch Language
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: backgroundColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Icon(
                              Icons.translate_rounded,
                              size: 26,
                              color: primaryColor,
                            ),
                        const SizedBox(width: 20),
                        Text(
                          "language",
                          style: greenTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.start,
                        ).tr(),
                      ],
                    ),
                    Switch(
                      //TODO: Iteration 3: Implement Switch Language
                      onChanged: (value) async {
                        if (user != null) {
                          final box = Hive.box<bool>(
                              'isLanguageEnglishBox_${user.uid}');
                          await box.put('isLanguageEnglish', value);
                        }
                        setState(() {
                          _isSwitched = value;
                        });
                        if (value) {
                          await EasyLocalization.of(context)!
                              .setLocale(Locale('id', 'ID'));
                        } else {
                          await EasyLocalization.of(context)!
                              .setLocale(Locale('en', 'US'));
                        }
                      },

                      value: _isSwitched,
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              // Sign Out Button
              signOutButton(),
            ],
          ),
        ),
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
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: greyColor,
          showUnselectedLabels: true,
          onTap: _changeSelectedIndex),
    );
  }
}
