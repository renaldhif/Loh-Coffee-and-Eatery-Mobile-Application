import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loh_coffee_eatery/models/menu_adapter.dart';
import 'package:loh_coffee_eatery/ui/pages/add_promo_page.dart';
import 'package:loh_coffee_eatery/ui/pages/cart_page.dart';
import 'package:loh_coffee_eatery/ui/pages/confirm_payment_page.dart';
import 'package:loh_coffee_eatery/ui/pages/delete_table_admin_page.dart';
import 'package:loh_coffee_eatery/ui/pages/faq_general_questions_page.dart';
import 'package:loh_coffee_eatery/ui/pages/home_page_recommend.dart';
import 'package:loh_coffee_eatery/ui/pages/order_details_customer_page.dart';
import 'package:loh_coffee_eatery/ui/pages/order_details_page.dart';
import 'package:loh_coffee_eatery/ui/pages/payment_details_page.dart';
import 'package:loh_coffee_eatery/ui/pages/payment_page.dart';
import 'package:loh_coffee_eatery/ui/pages/profile_menu_admin_page.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import 'package:loh_coffee_eatery/ui/pages/update_profile_page.dart';
import 'cubit/announce_cubit.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/menu_cubit.dart';
import 'cubit/order_cubit.dart';
import 'cubit/payment_cubit.dart';
import 'cubit/review_cubit.dart';
import 'cubit/table_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'cubit/announce_cubit.dart';
import 'cubit/reservation_cubit.dart';
import 'firebase_options.dart';
import '/ui/pages/add_menu_admin.dart';
import '/ui/pages/home_page_admin.dart';
import '/ui/pages/landing_page.dart';
import 'models/boolean_adapter.dart';
import 'ui/pages/about_us_page.dart';
import 'ui/pages/add_review_page.dart';
import 'ui/pages/add_table_admin.dart';
import 'ui/pages/cashier_page.dart';
import 'ui/pages/faq_account_management_page.dart';
import 'ui/pages/faq_order_management_page.dart';
import 'ui/pages/faq_reservation_management_page.dart';
import 'ui/pages/forgotpass_page.dart';
import 'ui/pages/promo_detail_page.dart';
import 'ui/pages/promo_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/howtouse_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/order_list_admin_page.dart';
import 'ui/pages/order_list_customer_page.dart';
import 'ui/pages/privacy_policy_page.dart';
import 'ui/pages/reservation_admin_page.dart';
import 'ui/pages/reservation_page.dart';
import 'ui/pages/reservation_success_page.dart';
import 'ui/pages/profile_menu_page.dart';
import 'ui/pages/customer_preferences.dart';
import 'ui/pages/request_reset.dart';
import 'ui/pages/review_page_admin.dart';
import 'ui/pages/signup_page.dart';
import 'ui/pages/payment_list_admin.dart';
import 'ui/pages/update_menu_admin.dart';
import 'ui/pages/menu_detail_page.dart';
import 'splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('id', 'ID')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      // startLocale: Locale('en', 'US'), 
      child: MyApp(),
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.deleteBoxFromDisk('shopping_box');

  Hive.registerAdapter(MenuAdapter());
  await Hive.openBox<MenuModel>('shopping_box');


  Hive.registerAdapter(BooleanAdapter());
  // await Hive.openBox<bool>('isDarkModeBox');

  // get user id from FirebaseAuth
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await Hive.openBox<bool>('isDarkModeBox_${user.uid}');
  }
  // else if(user == null){
  //   Hive.box('isDarkModeBox_${user!.uid}').close();
  // }
  
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => MenuCubit()),
        BlocProvider(create: (context) => ReviewCubit()),
        BlocProvider(create: (context) => TableCubit()),
        BlocProvider(create: (context) => PaymentCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => ReservationCubit()),
        BlocProvider(create: (context) => AnnounceCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: {
          //* Customer Routes
          '/': (context) => const SplashScreen(),
          '/landing': (context) => const LandingPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/forgotpassword': (context) => const ForgotPasswordPage(),
          '/requestreset': (context) => const RequestResetPage(),
          '/profilemenu': (context) => const ProfileMenuPage(),
          '/custpreferences':(context) => const CustomerPreferencesPage(),
          '/home': (context) => const HomePage(),
          '/home-recommend':(context) => const HomePageRecommend(),
          '/update-profile': (context) => const UpdateProfilePage(),
          '/submit-review' :(context) => const AddReviewPage(),
          '/cart': (context) => const CartPage(),
          '/cashier':(context) => const CashierPage(),
          '/payment':(context) => PaymentPage(),
          '/confirmpayment':(context) => const ConfirmPaymentPage(),
          '/orderlist':(context) => const OrderListCustomerPage(),
          '/orderdetails-customer':(context) => OrderDetailsCustomerPage(),
          '/menudetail':(context) => MenuDetailPage(),
          '/howtouse': (context) => const HowToUsePage(),
          '/aboutus': (context) => const AboutUsPage(),
          '/faq-account': (context) => const FAQAccountManagement(),
          '/faq-order'  : (context) => const FAQOrderManagement(),
          '/faq-reservation' : (context) => const FAQReservationManagement(),
          '/faq-general' : (context) => const FAQGeneralQuestions(),
          '/privacy-policy':(context) => const PrivacyPolicyPage(),
          '/reservation':(context) => const ReservationPage(),
          '/reservation-success':(context) => const ReservationSuccessPage(),
          '/promo':(context) => const PromoPage(),
          '/promodetail':(context) => PromoDetailPage(),
          
          //* Admin Routes
          '/home-admin': (context) => const HomePageAdmin(),
          '/profile-admin' : (context) => const ProfileMenuAdminPage(),
          '/addmenu': (context) => const AddMenuPageAdmin(),
          '/orderlist-admin':(context) => const OrderListAdminPage(),
          '/addtable' : (context) => const AddTablePageAdmin(),
          '/deletetable' : (context) => const DeleteTableAdminPage(),
          '/order-details':(context) => OrderDetailsPage(),
          '/payment-details':(context) => PaymentDetailsPage(),
          '/updatemenu': (context) => UpdateMenuPageAdmin(),
          '/reviews': (context) => const ReviewPageAdmin(),
          '/payment-admin':(context) => const PaymentListAdminPage(),
          '/reservation-admin':(context) => const ReservationAdminPage(),
          '/addpromo':(context) => const AddPromoPage(),
        },
      ),
    );
  }
}