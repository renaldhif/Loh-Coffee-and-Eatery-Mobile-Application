import 'package:flutter/material.dart';
import '/shared/theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
                  'Privacy Policy', 
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
                      '1. App Overview',
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

                    // TYPES OF DATA COLLECTED
                    Text(
                      '2. Types of Data We Collect',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'When you use the Loh Coffee and Eatery application, we may collect the following types of data:',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    
                    // 2.1
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '2.1.	',
                            style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                          TextSpan(
                            text: 'Personal Information: ',
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text: 'This includes your name and email address. We collect this information when you register for an account, make a reservation, or place an order.',
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 2.2
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '2.2.	',
                            style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                          TextSpan(
                            text: 'Order and Reservation Information: ',
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text: 'This includes the items you order, the time and date of your reservation, and the number of people in your party. We collect this information to process your orders and reservations.',
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 2.3
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '2.3.	',
                            style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                          TextSpan(
                            text: 'Payment Information: ',
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text: 'This includes your payment details, such as your bank account information. We collect this information to process your payments.',
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // USE OF YOUR DATA
                    Text(
                      '3. Use of Your Data',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We use your data to provide you with the best possible experience when using the Loh Coffee and Eatery application. Specifically, we use your data for the following purposes:',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    // 3.1
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: mainTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '3.1.	 ',
                            style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                          TextSpan(
                            text: 'Facilitate the creation of and secure your Account', 
                            style: mainTextStyle.copyWith(
                              fontWeight: black,
                            )
                          ),
                          TextSpan(
                            text: ' (Registered Users only)',
                            style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    //3.2
                    RichText(
                      text: TextSpan(
                        style: mainTextStyle.copyWith(fontSize: 14),
                        children: [
                          TextSpan(
                            text: '3.2.	',
                            style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                          TextSpan(
                            text: 'To process your orders and reservations: ',
                            style: mainTextStyle.copyWith(
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text:
                              'We use your personal information, order and reservation information, and payment information to process your orders and reservations.',
                              style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),

                    // 3.3
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '3.3.	',
                            style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                          TextSpan(
                            text: 'To improve our services: ',
                            style: mainTextStyle.copyWith(
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text:
                              'We may use your data to analyze customer behavior and preferences, which helps us improve our menu offerings and overall customer experience.',
                              style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                        textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    
                    // 3.4
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '3.4.	',
                            style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                          TextSpan(
                            text: 'To communicate with you: ',
                            style: mainTextStyle.copyWith(
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text:
                              'We may use your email address to send you updates about your orders and reservations, as well as promotional offers and other relevant information.',
                              style: mainTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height:20),

                    //Data security
                    Text(
                      '4. Data Security',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We take the security of your data very seriously. We use industry-standard encryption technologies when transferring and receiving customer data exchanged with our application. Firebase implements industry-standard security measures, such as encryption in transit and at rest, to protect user data. We also limit access to user data to authorized personnel who require access to provide services.',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height:20),
                    //Account
                    Text(
                      '5. Account',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Registered users of the Loh Coffee and Eatery mobile application can access and manage their account information, including personal data, by clicking on the "Profile" button in the application.',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height:20),
                    //Changes to this privacy policy 
                    Text(
                      '6. Changes to this Privacy Policy',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We may update this Privacy Policy from time to time to reflect changes in our practices or the law. We encourage you to review this Privacy Policy periodically to stay informed about our data collection and usage practices.',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height:20),
                    //Contact us
                    Text(
                      '7. Contact Us',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'If you have any questions about this Privacy Policy, please contact us at: ',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Email: support@lohcoffeeandeatery.com',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Phone: +62 812-3848-2109',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Address: Jl. Tukad Musi I No.9A, Renon, Denpasar Selatan, Kota Denpasar, Bali 80226',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    //operating hours
                    Text(
                      '8. Operating Hours',
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Our operating hours are from 10:00 AM to 9:00 PM, Monday to Sunday.',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    //date of last revision
                    Text(
                      'Date of Last Revision: March, 30th 2023',
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 50),
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