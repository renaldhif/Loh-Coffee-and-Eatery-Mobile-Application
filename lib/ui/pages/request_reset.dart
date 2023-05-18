import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '/shared/theme.dart';

class RequestResetPage extends StatelessWidget {
  const RequestResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        color: backgroundColor,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 75,
            ),
            Image.asset(
              'assets/images/resetsent.png',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'check_email_text'.tr(),
              style: greenTextStyle.copyWith(
                fontSize: 28,
                fontWeight: black,
                height: 1.25,
                letterSpacing: 0.25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'check_email_text_2'.tr(),
              style: mainTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
                height: 1.25,
                letterSpacing: 0.25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              title: 'sign_in'.tr(), 
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            ),
          ],
        ),
      ),
    );
  }
}