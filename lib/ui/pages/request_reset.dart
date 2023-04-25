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
              'Just one more step, \nlet\'s check your email',
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
              'We already send a password recover instructions to your email.\nIf you have not received the email after a few minutes, please check your spam folder.',
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
              title: 'Sign In', 
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