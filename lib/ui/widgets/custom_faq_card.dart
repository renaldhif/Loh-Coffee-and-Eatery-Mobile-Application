import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomFAQCard extends StatelessWidget{
  final String question;
  final String answer;
  
  const CustomFAQCard({
    required this.question,
    required this.answer,
  });

  @override Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      width: 0.9 * MediaQuery.of(context).size.width,
      // height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        border: Border.all(
          color: kUnavailableColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? backgroundColor :Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(1, 3),
          ),
        ],
        color: whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              question,
              style: greenTextStyle.copyWith(
                fontSize: 16,
                fontWeight: black,
                height: 1.25,
                letterSpacing: 0.25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              answer,
              style: mainTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
                height: 1.25,
                letterSpacing: 0.25,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}