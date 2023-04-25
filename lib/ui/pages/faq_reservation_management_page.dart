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
                  'Make a Reservation', 
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
                      question: 'How do I reserve a table in the Loh Coffee and Eatery mobile application?', 
                      answer: 'To reserve a table in the Loh Coffee and Eatery mobile application, go to the "Reserve" navigation page which is located in the bottom navigation bar. Then, select the date and time you want to reserve a table, select the table number available, then tap "Reserve Now".',
                    ),
                    SizedBox(height: 20),
                    // Q2
                    CustomFAQCard(
                      question: 'Can I reserve on the day when I make reservation??', 
                      answer: 'Sorry, you cannot reserve on the day when you make reservation. You can only reserve a table for the next day onwards.',
                    ),
                    SizedBox(height: 20),
                    // Q3
                    CustomFAQCard(
                      question: 'What time can reservation be made?',
                      answer: 'You can make reservation from 10:00 AM to 9:00 PM.',
                    ),
                    SizedBox(height: 20),
                    // Q4
                    CustomFAQCard(
                      question: 'What day reservation can be made?',
                      answer: 'You can make reservation from Monday to Sunday. National holidays are not included. Please check our social media for updates on our operating days.',
                    ),
                    SizedBox(height: 20),
                    // Q5
                    CustomFAQCard(
                      question: 'Can I cancel my reservation?',
                      answer: 'Yes, you can cancel your reservation. You can cancel your reservation by going to the "Reservation List" page which can be accessed through tapping the bottom navigation. Then, tap the "Cancel" button to cancel your reservation.',
                    ),
                    SizedBox(height: 20),
                    // Q6
                    CustomFAQCard(
                      question: 'Should I print the reservation proof?',
                      answer: 'No, you do not need to print the reservation proof. You can show the reservation proof on your mobile phone to the staff.',
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