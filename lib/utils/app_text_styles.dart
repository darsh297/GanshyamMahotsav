import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyle {
  TextStyle montserrat28W700 = GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w700);
  TextStyle montserrat22W700 = GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.w700);

  /// 18
  TextStyle montserrat18W700 = GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700);
  TextStyle montserrat18W600 = GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black);
  TextStyle montserrat18W600Green = GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primaryColor);

  /// 17
  TextStyle montserrat17W700 = GoogleFonts.montserrat(fontSize: 17, fontWeight: FontWeight.w700);

  /// 16 - Montserrat
  TextStyle montserrat16W700Green = GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primaryColor);
  TextStyle montserrat16W600 = GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.black);
  TextStyle montserrat16W600Green = GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  TextStyle montserrat16W500Black = GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);
  TextStyle montserrat16W500Grey = GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor);
  TextStyle montserrat16 = GoogleFonts.montserrat(fontSize: 16);

  /// 15
  TextStyle montserrat15W600 = GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.black);

  /// 14
  TextStyle montserrat14Grey = GoogleFonts.montserrat(fontSize: 14, color: AppColors.hintTextColor);
  TextStyle montserrat14W600Grey1 = GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey1);
  TextStyle montserrat14W700 = GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w700);
  TextStyle montserrat14W600 = GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600);
  TextStyle montserrat14W600White = GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.white);
  TextStyle montserrat14W500 = GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black);
  TextStyle montserrat14W600Green = GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryColor);

  /// 13
  TextStyle montserrat13W600 = GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600);

  /// 12
  TextStyle montserrat12W500 = GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.black);
  TextStyle montserrat12W600green = GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  TextStyle montserrat12W500Grey = GoogleFonts.montserrat(fontSize: 12, color: AppColors.hintTextColor, fontWeight: FontWeight.w500);
  TextStyle montserrat12W500Green = GoogleFonts.montserrat(fontSize: 12, color: AppColors.primaryColor, fontWeight: FontWeight.w500);

  /// 8
  TextStyle montserrat8W500 = GoogleFonts.montserrat(fontSize: 8, fontWeight: FontWeight.w500, color: AppColors.black);
  TextStyle montserrat10W500Grey = GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.hintTextColor);
}
