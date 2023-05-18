import 'package:easy_localization/easy_localization.dart';
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
                  'about_us'.tr(), 
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
                      'about_loh'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'about_loh_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'about_mobile'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'about_mobile_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'about_features'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'about_features_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'about_availability'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'about_availability_text'.tr(),
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