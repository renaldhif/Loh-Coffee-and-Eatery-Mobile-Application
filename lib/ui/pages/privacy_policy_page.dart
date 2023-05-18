import 'package:easy_localization/easy_localization.dart';
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
                  'privacy_policy'.tr(), 
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
                      '1. ' + 'app_overview'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'app_overview_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),

                    // TYPES OF DATA COLLECTED
                    Text(
                      '2. ' + 'data_type_collect'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'data_type_collect_text'.tr(),
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
                            text: 'personal_information'.tr()+ ': ',
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text: 'personal_information_text'.tr(),
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
                            text: 'order_and_reservation_information'.tr() +': ',
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text: 'order_and_reservation_information_text'.tr(),
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
                            text: 'payment_information'.tr() + ': ',
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text: 'payment_information_text'.tr(),
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
                      '3. ' + 'use_of_your_data'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'use_of_your_data_text'.tr(),
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
                            text: 'facilitate'.tr() + ': ', 
                            style: mainTextStyle.copyWith(
                              fontWeight: black,
                            )
                          ),
                          TextSpan(
                            text: 'facilitate_text'.tr(),
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
                            text: 'process_order_reserve'.tr(),
                            style: mainTextStyle.copyWith(
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text:
                              'process_order_reserve_text'.tr(),
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
                            text: 'improve_our_service'.tr(),
                            style: mainTextStyle.copyWith(
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text:
                              'improve_our_service_text'.tr(),
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
                            text: 'communicate_with_you'.tr(),
                            style: mainTextStyle.copyWith(
                              fontWeight: black,
                            ),
                          ),
                          TextSpan(
                            text:
                              'communicate_with_you_text'.tr(),
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
                      '4. ' + 'data_security'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'data_security_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height:20),
                    //Account
                    Text(
                      '5. ' + 'account'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'account_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height:20),
                    //Changes to this privacy policy 
                    Text(
                      '6. ' + 'changes'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'changes_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height:20),
                    //Contact us
                    Text(
                      '7. ' + 'contact_us'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'contact_us_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'email_loh'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'phone_loh'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'address_loh'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    //operating hours
                    Text(
                      '8. ' + 'operating_hours'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'operating_hours_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 50),
                    //date of last revision
                    Text(
                      'revision'.tr(),
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