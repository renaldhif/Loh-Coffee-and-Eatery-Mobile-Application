import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '/shared/theme.dart';

class CashierPage extends StatelessWidget {
  const CashierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Container(
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
              'Thank you',
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
              'You can go now to the cashier. Your order will be processed after your payment accepted by the cashier.',
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
              title: 'Back to Home Page', 
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              }
            ),
          ],
        ),
      ),
    );
  }
}