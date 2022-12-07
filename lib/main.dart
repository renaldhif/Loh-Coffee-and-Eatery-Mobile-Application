import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/ui/pages/home_page_admin.dart';
import '/ui/pages/landing_page.dart';
import 'cubit/auth_cubit.dart';
import 'ui/pages/forgotpass_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/profile_menu_page.dart';
import 'ui/pages/signup_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
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
