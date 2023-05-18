import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_faq_card.dart';
import '/shared/theme.dart';

class FAQAccountManagement extends StatelessWidget {
  const FAQAccountManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30), 
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
              const SizedBox(height: 20), 
              Center(
                child: Text(
                  'managing_your_account'.tr(), 
                  style: greenTextStyle.copyWith(
                    fontSize: 22, 
                    fontWeight: bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    // Q1
                    CustomFAQCard(
                      question: 'faq_account_1'.tr(), 
                      answer: 'faq_account_1_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q2
                    CustomFAQCard(
                      question: 'faq_account_2'.tr(), 
                      answer: 'faq_account_2_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q3
                    CustomFAQCard(
                      question: 'faq_account_3'.tr(),
                      answer: 'faq_account_3_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q4
                    CustomFAQCard(
                      question: 'faq_account_4'.tr(),
                      answer: 'faq_account_4_ans'.tr(),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}