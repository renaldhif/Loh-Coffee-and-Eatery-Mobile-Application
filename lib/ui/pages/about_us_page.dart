import 'package:flutter/material.dart';
import '/shared/theme.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
                  'About Us', 
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
                    const SizedBox(height: 20),
                    // APP OVERVIEW
                    Text(
                      'About Loh Coffee and Eatery',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Loh Coffee and Eatery is a cafe that serves coffee, tea, and various food items such as sandwiches, salads, and pastries.',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'About Loh Coffee and Eatery Mobile Application',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'The Loh Coffee and Eatery mobile application is designed to streamline the order and reservation process for customers, making it easier and more convenient to place orders and reserve tables at the cafe.',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Features of Loh Coffee and Eatery Mobile Application',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'The Loh Coffee and Eatery mobile application includes features such as registration and password reset, managing user information and preferences, managing the cafe\'s menu and reviews, placing and managing orders, making payments, reserving tables, and receiving announcements and recommendations from the cafe.',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loh Coffee and Eatery Mobile Application Availability',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'The Loh Coffee and Eatery mobile application is available on both Android and iOS devices.',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
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