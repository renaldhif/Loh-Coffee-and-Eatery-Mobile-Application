import 'package:flutter/material.dart';
import '/shared/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String title, label, hintText;
  TextEditingController controller = TextEditingController();

  CustomTextFormField({
    super.key,
    required this.title,
    required this.label,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(title, // this field is required
            style: greenTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 50,
            // decoration: BoxDecoration(
            //   color: whiteColor,
            //   borderRadius: BorderRadius.circular(10),
            //   border: Border.all(
            //     color: primaryColor,
            //     width: 1,
            //   ),
            // ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label, // this field is required
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: hintText, // this field is required
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
