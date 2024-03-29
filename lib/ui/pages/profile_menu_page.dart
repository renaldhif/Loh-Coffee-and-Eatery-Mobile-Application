import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loh_coffee_eatery/cubit/auth_cubit.dart';
import '../../cubit/theme_cubit.dart';
import '../../models/user_model.dart';
import '/ui/widgets/custom_button_red.dart';
import '/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({super.key});

  @override
  State<ProfileMenuPage> createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  // boolean for dark mode
  // bool _isDarkMode = false;
  // boolean for switch language
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    initializeTheme(false);
    // Call the initializeTheme function here
  }


  // To change the selected value of bottom navigation bar
  int _selectedIndex = 4;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/reservation');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/orderlist');
          break;
        case 3:
          Navigator.pushNamed(context, '/promo');
          break;
        // case 4:
        //   Navigator.pushReplacementNamed(context, '/profilemenu');
        //   break;
      }
    });
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
              title: 'sign_out'.tr(),
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
    Box<bool> isLanguageEnglishBox = Hive.box<bool>('isLanguageEnglishBox_${user!.uid}');
      // _isSwitched = isLanguageEnglishBox.get('isLanguageEnglish')!;
      _isSwitched = isLanguageEnglishBox.get('isLanguageEnglish') ?? false;
      print('isSwitched: $_isSwitched');
    EasyLocalization.of(context)!
    .setLocale(_isSwitched ? Locale('id', 'ID') : Locale('en', 'US'));
    // _isSwitched = isLanguageEnglish;

    Box<bool> isDarkModeBox = Hive.box<bool>('isDarkModeBox_${user!.uid}');
    bool _isDarkMode = isDarkModeBox.get('isDarkMode') ?? false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
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
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'profile_menu'.tr(),
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
                        const SizedBox(width: 20),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is AuthSuccess) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/update-profile');
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // Account Setting title
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  'account_settings'.tr(),
                  style: greenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              // Account Setting Content

              // Edit Preferences
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
                          Icons.fastfood_rounded,
                          color: primaryColor,
                          size: 26,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'edit_menu_preferences'.tr(),
                          style: greenTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/custpreferences');
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Submit Review
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
                          Icons.rate_review_rounded,
                          size: 26,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "submit_review".tr(),
                          style: greenTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/submit-review');
                      },
                      icon: Icon(
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
                  'general_settings'.tr(),
                  style: greenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              // General Setting Content

              // Dark Mode
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
                          Icons.dark_mode_rounded,
                          size: 26,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "dark_mode".tr(),
                          style: greenTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Switch(
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
                          "language".tr(),
                          style: greenTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Switch(
                      onChanged: (value) async {
                        final user = FirebaseAuth.instance.currentUser;
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
                        // if (value) {
                        //   await EasyLocalization.of(context)!.setLocale(
                        //       Locale('en', 'US')); // Set English locale
                        // } else {
                        //   await EasyLocalization.of(context)!.setLocale(
                        //       Locale('id', 'ID')); // Set Indonesian locale
                        // }
                      },
                      value: _isSwitched,
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),

              // How to Use Loh App
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
                          Icons.help_rounded,
                          size: 26,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "how_to_use".tr(),
                          style: greenTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/howtouse');
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
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
          backgroundColor: whiteColor,
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
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: greyColor,
          showUnselectedLabels: true,
          onTap: _changeSelectedIndex),
    );
  }
}
