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

class HowToUsePage extends StatefulWidget {
  const HowToUsePage({super.key});

  @override
  State<HowToUsePage> createState() => _HowToUsePageState();
}

class _HowToUsePageState extends State<HowToUsePage> {
  void initState() {
    super.initState();
    initializeTheme(false);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'how_to_use'.tr(),
                        style: greenTextStyle.copyWith(
                          fontSize: 28,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  'about_us'.tr(),
                  style: greenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              // About Us
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
                          Icons.description,
                          color: primaryColor,
                          size: 26,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "about_us".tr(),
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
                        Navigator.pushNamed(context, '/aboutus');
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // FAQ
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  'frequently_asked_questions'.tr(),
                  style: greenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              // FAQ Managing Account
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
                          Icons.manage_accounts_rounded,
                          color: primaryColor,
                          size: 26,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "managing_your_account".tr(),
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
                        Navigator.pushNamed(context, '/faq-account');
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // FAQ Order Management
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
                          Icons.restaurant_menu_rounded,
                          color: primaryColor,
                          size: 26,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "ordering_food_and_payment".tr(),
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
                        Navigator.pushNamed(context, '/faq-order');
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // FAQ Make a Reservation
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
                          Icons.book_online_rounded,
                          color: primaryColor,
                          size: 26,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "make_a_reservation".tr(),
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
                        Navigator.pushNamed(context, '/faq-reservation');
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              //General questions
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
                          Icons.question_answer_rounded,
                          color: primaryColor,
                          size: 26,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "general_questions".tr(),
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
                        Navigator.pushNamed(context, '/faq-general');
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Privacy Policy
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  'privacy_policy'.tr(),
                  style: greenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              // Privacy Policy Button
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
                          Icons.privacy_tip_rounded,
                          size: 26,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "privacy_policy".tr(),
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
                        Navigator.pushNamed(context, '/privacy-policy');
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
            ],
          ),
        ),
      ),
    );
  }
}
