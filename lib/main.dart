import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/ui/pages/landing_page.dart';
import 'shared/theme.dart';

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
        },
      ),
    );
  }
}
