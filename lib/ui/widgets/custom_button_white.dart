import 'package:flutter/material.dart';
import '/shared/theme.dart';

class CustomButtonWhite extends StatelessWidget {
  final String title;
  final double width, fontSize;
  final Function() onPressed;
  final EdgeInsets margin;

  const CustomButtonWhite({
    super.key,
    required this.title,
    this.width = double.infinity,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      margin: margin,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            side: const BorderSide(
              color: primaryColor,
            ),
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: greenTextStyle.copyWith(
                fontSize: fontSize,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}