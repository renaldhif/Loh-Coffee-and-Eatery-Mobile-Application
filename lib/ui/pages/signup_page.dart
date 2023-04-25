import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/cubit/auth_cubit.dart';
import '../widgets/custom_button.dart';
import '/shared/theme.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // TextEditingControllers
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateInputController = TextEditingController();
  // Boolean to show hide password
  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Orange list
                Container(
                  width: double.infinity,
                  height: 400,
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
                  height: 395,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(defaultRadius),
                      bottomRight: Radius.circular(defaultRadius),
                    ),
                    child: Image.asset(
                      'assets/images/signup.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
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
                      style: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Enter your email',
                        hintStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          borderSide:  BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          borderSide:  BorderSide(
                            color: primaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Password
                  Text(
                    'Password',
                    style: mainTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _isObsecure,
                      style: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        hintText: 'Enter your password',
                        hintStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecure = !_isObsecure;
                            });
                          },
                          icon: Icon(
                            _isObsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _isObsecure ? greyColor : primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          borderSide:  BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          borderSide:  BorderSide(
                            color: primaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ), // Email
                  Text(
                    'Full Name',
                    style: mainTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _fullnameController,
                      keyboardType: TextInputType.emailAddress,
                      style: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Enter your full name',
                        hintStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:  BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:  BorderSide(
                            color: primaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  // Email
                  Text(
                    'Date of Birth',
                    style: mainTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      style: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                      ),
                      controller: _dateInputController,
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050),
                          builder: (context, child) {
                            return FittedBox(
                              child: Theme(
                                data: isDarkMode 
                                ? ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: primaryColor,
                                  ),
                                ) 
                                : ThemeData.light().copyWith(
                                  colorScheme:  ColorScheme.light(
                                    primary: primaryColor,
                                  ),
                                  buttonTheme: const ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary,
                                  ),
                                ),
                                child: child!,
                              ),
                            );
                          },
                        );
                        if (pickedDate != null) {
                          var formatDate =
                              DateTime.parse(pickedDate.toString());
                          var formattedDate =
                              "${formatDate.day}-${formatDate.month}-${formatDate.year}";
                          _dateInputController.text = formattedDate;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        labelStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Enter your date of birth',
                        hintStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:  BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:  BorderSide(
                            color: primaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if(state is AuthSuccess){
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      }
                      else if(state is AuthFailed){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return  Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      }
                      return CustomButton(
                        title: 'Sign Up',
                        onPressed: () {
                          // Navigator.pushNamed(context, '/');
                          context.read<AuthCubit>().register(
                            email: _emailController.text,
                            password: _passwordController.text,
                            name: _fullnameController.text,
                            dob: _dateInputController.text,
                          );
                        },
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: orangeTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Sign In',
                          style: greenTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}