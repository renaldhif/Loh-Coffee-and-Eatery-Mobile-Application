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
                  'Managing Account', 
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
                  children: const [
                    SizedBox(height: 20),
                    // Q1
                    CustomFAQCard(
                      question: 'How do I register for the Loh Coffee and Eatery mobile application?', 
                      answer: 'To register for an account in the Loh Coffee and Eatery mobile application, click on the "Register" button on the login page and follow the instructions to enter your personal information and create a new account.'
                    ),
                    SizedBox(height: 20),
                    // Q2
                    CustomFAQCard(
                      question: 'How do I reset my password in the Loh Coffee and Eatery mobile application?', 
                      answer: 'To reset your password in the Loh Coffee and Eatery mobile application, click on the "Reset Password" button on the login page and follow the instructions to enter your email address and reset your password.'
                    ),
                    SizedBox(height: 20),
                    // Q3
                    CustomFAQCard(
                      question: 'How do I manage my user information and preferences in the Loh Coffee and Eatery mobile application?',
                      answer: 'To manage your user information and preferences in the Loh Coffee and Eatery mobile application, go to the \'Profile\' Navigation on the bottom navigation of the app and edit your personal information and preferences.',
                    ),
                    SizedBox(height: 20),
                    // Q4
                    CustomFAQCard(
                      question: 'Can I change my email address or name?',
                      answer: 'Yes, you can change your email address or name by going to \'Profile\' Navigation on the bottom navigation of the app and tap on arrow button in your profile detail column.',
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