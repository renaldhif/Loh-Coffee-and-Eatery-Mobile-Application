import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_faq_card.dart';
import '/shared/theme.dart';

class FAQReservationManagement extends StatelessWidget {
  const FAQReservationManagement({super.key});

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
                  'make_a_reservation'.tr(), 
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
                      question: 'faq_reserve_1'.tr(), 
                      answer: 'faq_reserve_1_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q2
                    CustomFAQCard(
                      question: 'faq_reserve_2'.tr(), 
                      answer: 'faq_reserve_2_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q3
                    CustomFAQCard(
                      question: 'faq_reserve_3'.tr(),
                      answer: 'faq_reserve_3_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q4
                    CustomFAQCard(
                      question: 'faq_reserve_4'.tr(),
                      answer: 'faq_reserve_4_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q5
                    CustomFAQCard(
                      question: 'faq_reserve_5'.tr(),
                      answer: 'faq_reserve_5_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q6
                    CustomFAQCard(
                      question: 'faq_reserve_6'.tr(),
                      answer: 'faq_reserve_6_ans'.tr(),
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