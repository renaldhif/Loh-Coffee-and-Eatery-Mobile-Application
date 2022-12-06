import 'package:flutter/material.dart';
import '/ui/pages/home_page_admin.dart';
import '/ui/pages/landing_page.dart';
import 'ui/pages/forgotpass_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/profile_menu_page.dart';
import 'ui/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        routes: {
          '/': (context) => const LandingPage(),
          '/login':(context) => const LoginPage(),
          '/signup':(context) => const SignUpPage(),
          '/forgotpassword' : (context) => const ForgotPasswordPage(),
          '/profilemenu': (context) => const ProfileMenuPage(), 
          '/home':(context) => const HomePage(),
          '/home-admin':(context) => const HomePageAdmin(),
        },
      ),
    );
  }
}
