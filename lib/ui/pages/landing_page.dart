import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import '/shared/theme.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: whiteColor,
        child: Column(
          children: [
            Stack(
              children: [
                // Orange list
                Container(
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(defaultRadius),
                      bottomRight: Radius.circular(defaultRadius),
                    ),
                  ),
                ),
    
                // Cover Image
                SizedBox(
                  height: 595,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(defaultRadius),
                      bottomRight: Radius.circular(defaultRadius),
                    ),
                    child: Image.asset(
                      'assets/images/landing_page.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 52),
              child: Column(
                children: [
                  CustomButton(
                    title: 'Sign Up', 
                    onPressed: (){
                      Navigator.pushNamed(context, '/profilemenu');
                    },
                  ),
                  const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: orangeTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: regular,
                          ),
                        ),
                        TextButton(
                          onPressed: (){},
                          child: Text(
                            'Sign In', style: greenTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
