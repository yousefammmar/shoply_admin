import 'package:flutter/material.dart';

class AppColors {
  static const Color backgrround = Color(0xffffffff);
  // Shoply brand green, also used for filled surfaces in dark mode
  static const Color primaryColor = Color(0xFF07583F);
  static const Color onPrimary = Color(0xffffffff);
  static const Color secondary = Color(0xFFE8F3EE);

  static const Color error = Colors.red;
  static const Color onError = Color(0xffffffff);

  static const Color cardBorder = Color(0xFFEDEFEE);
  static const Color greyText = Color(0xFF7A817E);
  static const Color fieldFill = Color(0xFFEFEFEF);

  // dark mode
  static const Color darkBackground = Color(0xFF101413);
  static const Color darkRaised = Color(0xFF1B211F);
  // brand green lightened so text and icons stay readable on dark surfaces
  static const Color darkPrimary = Color(0xFF5CC29A);
  static const Color darkOnPrimary = Color(0xFF00382A);
  static const Color darkSecondary = Color(0xFF0F3A2D);
  static const Color darkOnSecondary = Color(0xFFB4E9D1);
  static const Color darkText = Color(0xFFE4E8E6);
  static const Color darkCardBorder = Color(0xFF2C3431);
  static const Color darkGreyText = Color(0xFFA0A8A4);
  static const Color darkFieldFill = Color(0xFF232A27);

  // order status colors
  static const Color pending = Color(0xFFF08A24);
  static const Color shipped = Color(0xFF0F9F8F);
  static const Color delivered = Color(0xFF1E9E5A);
  static const Color cancelled = Color(0xFFE53935);
}
