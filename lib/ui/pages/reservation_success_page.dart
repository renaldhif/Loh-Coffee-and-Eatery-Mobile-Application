import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '/shared/theme.dart';

class ReservationSuccessPage extends StatelessWidget {
  const ReservationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Container(
        width: double.infinity,
        color: backgroundColor,
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
              'Reservation Sent!',
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
              'Thank you for your reservation. \nWe look forward to seeing you soon!',
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
              title: 'Back to homepage', 
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