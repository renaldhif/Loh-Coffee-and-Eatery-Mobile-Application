// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// // Colors
// const Color primaryColor = Color(0xFF075A30);
// const Color secondaryColor = Color(0xFFF17532);
// const Color greyColor = Color(0xFF555555);
// const Color kUnavailableColor = Color(0xFFFAFAFA);
// const Color whiteColor = Color(0xFFFFFFFF);
// const Color backgroundColor = Color(0xFFE5E5E5);

// // Text Styles
// TextStyle mainTextStyle = GoogleFonts.inter(
//   color: greyColor,
// );

// TextStyle greenTextStyle = GoogleFonts.inter(
//   color: primaryColor,
// );

// TextStyle orangeTextStyle = GoogleFonts.inter(
//   color: secondaryColor,
// );

// TextStyle whiteTextStyle = GoogleFonts.inter(
//   color: whiteColor,
// );

// // Font Weights
// FontWeight light = FontWeight.w300;
// FontWeight regular = FontWeight.w400;
// FontWeight medium = FontWeight.w500;
// FontWeight semiBold = FontWeight.w600;
// FontWeight bold = FontWeight.w700;
// FontWeight extraBold = FontWeight.w800;
// FontWeight black = FontWeight.w900;

// // Margins
// double defaultMargin = 36;
// double defaultRadius = 12;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

// late bool isDarkMode;
bool isDarkMode = false;


// TextStyle getDarkPrimary(bool isDarkMode) {
//   return GoogleFonts.inter(color: isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF075A30));
// }

// Colors
// Color primaryColor = isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF075A30);
// Color secondaryColor = isDarkMode ? Color(0xFFFC8B3C) : Color(0xFFF17532);
// Color greyColor = isDarkMode ? Color(0xFF7E7E7E) : Color(0xFF555555);
// Color kUnavailableColor = isDarkMode ? Color(0xFF3D3D3D) : Color(0xFFFAFAFA);
// Color whiteColor = isDarkMode ? Color(0xFFCCBBAA) : Color(0xFFFFFFFF);
// Color backgroundColor = isDarkMode ? Color(0xFFBB22CD) : Color(0xFFE5E5E5);

//initialize isDarkMode
void initializeTheme(bool isDark) {
  final user = FirebaseAuth.instance.currentUser;
  if(user != null) {
      isDarkMode = Hive.box<bool>('isDarkModeBox_${user.uid}').get('isDarkMode') ?? false;
  }
  else {
    isDarkMode = false;
  }

  // isDarkMode = Hive.box<bool>('isDarkModeBox').get('isDarkMode') ?? false;
  primaryColor = isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF075A30);
  secondaryColor = isDarkMode ? const Color(0xFFFC8B3C) : const Color(0xFFF17532);
  greyColor = isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF555555);
  kUnavailableColor = isDarkMode ? const Color(0xFF3D3D3D) : const Color(0xFFFFFFFF);
  whiteColor = isDarkMode ? const Color(0xFF313131) : const Color(0xFFFFFFFF);
  backgroundColor = isDarkMode ? const Color(0xFF212121) : const Color(0xFFF5F5F5);
  greenButtonColor = isDarkMode ? Color(0xFF64A568) : Color(0xFF075A30);

  mainTextStyle = GoogleFonts.inter(
    color: greyColor,
  );

  greenTextStyle = GoogleFonts.inter(
    // color: primaryColor,
    // color: isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF075A30),
    color: primaryColor
  );

  orangeTextStyle = GoogleFonts.inter(
    color: secondaryColor,
  );

  whiteTextStyle = GoogleFonts.inter(
    color: whiteColor,
  );

  whiteTextButtonStyle = GoogleFonts.inter(
    color: whiteTextButtonColor,
  );

  greenTextButtonStyle = GoogleFonts.inter(
    color: greenButtonColor,
  );

}
// bool isDarkMode = false;

// Colors
Color primaryColor = isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF075A30);
Color secondaryColor = isDarkMode ? Color(0xFFFC8B3C) : Color(0xFFF17532);
Color greyColor = isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF555555);
Color kUnavailableColor = isDarkMode ? Color(0xFF3D3D3D) : Color(0xFFFFFFFF);
Color whiteColor = isDarkMode ? Color(0xFF313131) : Color(0xFFFFFFFF);
Color backgroundColor = isDarkMode ? const Color(0xFF212121) : const Color(0xFFF5F5F5);
Color greenButtonColor = isDarkMode ? Color(0xFF64A568) : Color(0xFF075A30);
Color whiteTextButtonColor = isDarkMode ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);

// Text Styles
TextStyle mainTextStyle = GoogleFonts.inter(
  color: greyColor,
);

TextStyle greenTextStyle = GoogleFonts.inter(
  // color: primaryColor,
  // color: isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF075A30),
  color: primaryColor
);

TextStyle orangeTextStyle = GoogleFonts.inter(
  color: secondaryColor,
);

TextStyle whiteTextStyle = GoogleFonts.inter(
  color: whiteColor,
);

TextStyle whiteTextButtonStyle = GoogleFonts.inter(
  color: whiteTextButtonColor,
);

TextStyle greenTextButtonStyle = GoogleFonts.inter(
  color: greenButtonColor,
);

// Font Weights
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

// Margins
double defaultMargin = 36;
double defaultRadius = 12;