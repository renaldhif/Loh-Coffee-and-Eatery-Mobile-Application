import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/main.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';
import 'dart:async';
import 'package:loh_coffee_eatery/ui/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // start the splash screen
  startSplashScreen() async {
  var duration = const Duration(seconds: 3);
  return Timer(duration, () {
    Navigator.of(context).pushReplacement(
        // without animation
        // MaterialPageRoute(builder: (context) => const LoginPage()));

        // go to login page with animation
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const LoginPage(),
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (context, animation1, animation2, child) => FadeTransition(
            opacity: animation1,
            child: child,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/lohlogo.jpeg",
              width: 400,
              height: 400,
              fit: BoxFit.contain,
            ),
          ),
           CircularProgressIndicator(
            color: primaryColor,
          )
        ],
      ),
    );
  }
}
