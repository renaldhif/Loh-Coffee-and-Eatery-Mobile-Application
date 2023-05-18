import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../widgets/custom_button.dart';
import '/shared/theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  Widget resetPasswordButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthInitial){
          Navigator.pushReplacementNamed(context, '/requestreset');
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }
        return CustomButton(
          title: 'send_email'.tr(),
          onPressed: () {
            if (_emailController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('email_cant_be_empty'.tr()),
                ),
              );
            } else {
              context
                .read<AuthCubit>()
                .resetPassword(email: _emailController.text);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back and Picture
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 38,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Image.asset(
                        'assets/images/forgotpassword.png',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Content
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text('forgot_password'.tr(),
                        style: greenTextStyle.copyWith(
                          fontSize: 36,
                          fontWeight: extraBold,
                        )),
                    // Subtitle
                    const SizedBox(height: 10),
                    Text(
                      'reset_pass_text'.tr(),
                      style: mainTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 30),
                    // Email Text Field
                    Text(
                      'email_address'.tr(),
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
                        style: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        decoration: InputDecoration(
                          labelText: 'email'.tr(),
                          labelStyle: mainTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: 'enter_your_email'.tr(),
                          hintStyle: mainTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
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
                          'remember_account'.tr(),
                          style: orangeTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'back_to_login'.tr(),
                            style: mainTextStyle.copyWith(
                              fontWeight: bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Reset Password Button
                    resetPasswordButton(),
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
