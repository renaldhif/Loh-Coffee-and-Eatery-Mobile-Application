import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loh_coffee_eatery/ui/pages/update_profile_page.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/menu_cubit.dart';
import 'firebase_options.dart';
import '/ui/pages/add_menu_admin.dart';
import '/ui/pages/home_page_admin.dart';
import '/ui/pages/landing_page.dart';
import 'ui/pages/forgotpass_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/profile_menu_page.dart';
import 'ui/pages/request_reset.dart';
import 'ui/pages/signup_page.dart';
import 'splash.dart';

void main() async {
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
        BlocProvider(create: (context) => MenuCubit()),
      ],
      child: MaterialApp(
        // home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        // initialRoute: '/splash',
        routes: {
          // '/splash': (context) => SplashScreen(),
          '/': (context) => const SplashScreen(),
          '/landing': (context) => const LandingPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/forgotpassword': (context) => const ForgotPasswordPage(),
          '/requestreset': (context) => const RequestResetPage(),
          '/profilemenu': (context) => const ProfileMenuPage(),
          '/home': (context) => const HomePage(),
          '/update-profile': (context) => const UpdateProfilePage(),
          
          // admins
          '/home-admin': (context) => const HomePageAdmin(),
          '/addmenu': (context) => const AddMenuPageAdmin(),
        },
      ),
    );
  }
}
