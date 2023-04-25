import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_faq_card.dart';
import '/shared/theme.dart';

class FAQGeneralQuestions extends StatelessWidget {
  const FAQGeneralQuestions ({super.key});

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
                  'General Questions', 
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
                      question: 'How do I switch the language in the Loh Coffee and Eatery application?', 
                      answer: 'Our application provide 2 languages which are English as the default and Bahasa. To switch the language, go to the "Profile" navigation page which is located in the bottom navigation bar. Then, tap the "Switch to Bahasa" toggle button to switch the language to Bahasa. To switch back to English, tap again the toggle button.'
                    ),
                    SizedBox(height: 20),
                    // Q2
                    CustomFAQCard(
                      question: 'How do I switch to dark mode in the Loh Coffee and Eatery application?', 
                      answer: 'Our application provide 2 themes which are light mode as the default and dark mode. To switch to dark mode, go to the "Profile" navigation page which is located in the bottom navigation bar. Then, tap the "Switch to Dark Mode" toggle button to switch to dark mode. To switch back to light mode, tap again the toggle button.',
                    ),
                    SizedBox(height: 20),
                    // Q2
                    CustomFAQCard(
                      question: 'Will the Dark Mode and language setting be saved for future use?', 
                      answer: 'Yes, the Dark Mode and language setting will be saved for future use.',
                    ),
                    SizedBox(height: 20),
                    // Q2
                    CustomFAQCard(
                      question: 'Can I submit a review of my experience at Loh Coffee and Eatery in the application?', 
                      answer: 'Yes, you can submit a review by going to the Submit Review section and providing your feedback. Your feedback will be reviewed by our team to improve our service quality.',
                    ),
                    SizedBox(height: 20),
                    // Q3
                    CustomFAQCard(
                      question: ' Can I edit my menu preferences in the Loh Coffee and Eatery application?',
                      answer: 'Yes, you can edit your menu preferences by going to the Manage Menu Preferences section and selecting the tags you prefer for each menu category.',
                    ),
                    SizedBox(height: 20),
                    // Q4
                    CustomFAQCard(
                      question: 'Can the Loh Coffee and Eatery application recommend menu items based on my preferences?',
                      answer: 'Yes, you can view the recommended menu items based on your preferences, most loved, and most ordered by going to the Recommended Menu section.',
                    ),
                    SizedBox(height: 20),
                    
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