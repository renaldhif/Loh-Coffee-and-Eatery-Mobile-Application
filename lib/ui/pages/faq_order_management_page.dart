import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_faq_card.dart';
import '/shared/theme.dart';

class FAQOrderManagement extends StatelessWidget {
  const FAQOrderManagement({super.key});

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
                  'ordering_food_and_payment'.tr(), 
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
                      question: 'faq_order_1'.tr(), 
                      answer: 'faq_order_1_ans'.tr()
                    ),
                    SizedBox(height: 20),
                    // Q2
                    CustomFAQCard(
                      question: 'faq_order_2'.tr(), 
                      answer: 'faq_order_2_ans'.tr()
                    ),
                    SizedBox(height: 20),
                    // Q3
                    CustomFAQCard(
                      question: 'faq_order_3'.tr(),
                      answer: 'faq_order_3_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q4
                    CustomFAQCard(
                      question: 'faq_order_4'.tr(),
                      answer: 'faq_order_4_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q5
                    CustomFAQCard(
                      question: 'faq_order_5'.tr(),
                      answer: 'faq_order_5_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q6
                    CustomFAQCard(
                      question: 'faq_order_6'.tr(),
                      answer: 'faq_order_6_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q7
                    CustomFAQCard(
                      question: 'faq_order_7'.tr(),
                      answer: 'faq_order_7_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q8
                    CustomFAQCard(
                      question: 'faq_order_8'.tr(),
                      answer: 'faq_order_8_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // Q9
                    CustomFAQCard(
                      question: 'faq_order_9'.tr(),
                      answer: 'faq_order_9_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // 10
                    CustomFAQCard(
                      question: 'faq_order_10'.tr(),
                      answer: 'faq_order_10_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // 11
                    CustomFAQCard(
                      question: 'faq_order_11'.tr(),
                      answer: 'faq_order_11_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // 12
                    CustomFAQCard(
                      question: 'faq_order_12'.tr(),
                      answer: 'faq_order_12_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // 13
                    CustomFAQCard(
                      question: 'faq_order_13'.tr(),
                      answer: 'faq_order_13_ans'.tr(),
                    ),
                    SizedBox(height: 20),
                    // 14
                    CustomFAQCard(
                      question: 'faq_order_14'.tr(),
                      answer: 'faq_order_14_ans'.tr(),
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