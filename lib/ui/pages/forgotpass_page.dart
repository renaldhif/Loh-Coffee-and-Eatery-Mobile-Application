import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '/shared/theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              // Back and Picture
              SizedBox(
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: const Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 38,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultRadius),
                      child: Image.asset(
                        'assets/images/forgotpassword.png',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              
              // Content
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Forgot Password?', 
                      style: greenTextStyle.copyWith(
                        fontSize: 36,
                        fontWeight: extraBold,
                      )
                    ),
                    // Subtitle
                    const SizedBox(height: 10),
                    Text(
                      'Don’t worry! It happens. Please enter your email address associated with your account and we’ll send an email with instructions to reset your password.', 
                      style: mainTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 30),
                    // Email Text Field
                    Text(
                      'Email address',
                      style: mainTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: primaryColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Back to Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Remember your account?',
                          style: orangeTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          child: Text(
                            'Back to Login',
                            style: mainTextStyle.copyWith(
                              fontWeight: bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      title: 'Send Email',
                      //* TODO: Add function to send email
                      onPressed: (){},
                    ),
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