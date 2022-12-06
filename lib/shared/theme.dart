import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const Color primaryColor = Color(0xFF075A30);
const Color secondaryColor = Color(0xFFF17532);
const Color greyColor = Color(0xFF555555);
const Color kUnavailableColor = Color(0xFFFAFAFA);
const Color whiteColor = Color(0xFFFFFFFF);
const Color backgroundColor = Color(0xFFE5E5E5);

// Text Styles
TextStyle mainTextStyle = GoogleFonts.inter(
  color: greyColor,
);

TextStyle greenTextStyle = GoogleFonts.inter(
  color: primaryColor,
);

TextStyle orangeTextStyle = GoogleFonts.inter(
  color: secondaryColor,
);

TextStyle whiteTextStyle = GoogleFonts.inter(
  color: whiteColor,
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