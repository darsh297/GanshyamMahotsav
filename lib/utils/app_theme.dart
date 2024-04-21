import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  ThemeData themeData = ThemeData(
      primaryColor: AppColors.primaryColor,
      useMaterial3: true,

      /// Text Button theme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.only(right: 6)),
          minimumSize: MaterialStateProperty.all<Size>(Size.zero),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          // textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          //   (Set<MaterialState> states) {
          //     return GoogleFonts.montserrat(fontSize: 16);
          //   },
          // ),
        ),
      ),

      /// Elevated Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
                return const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
              },
            ),
            elevation: MaterialStateProperty.all(0.2),
            foregroundColor: MaterialStateProperty.all<Color>(AppColors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor)),
      ),

      /// Cursor color
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.textFieldBorderColor,
        selectionColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,
      ),

      /// TextBox theme
      inputDecorationTheme: InputDecorationTheme(
        // hintStyle: AppTextStyle().montserrat16W500Grey,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldBorderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        activeIndicatorBorder: BorderSide(color: AppColors.textFieldBorderColor, width: 1),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldBorderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        outlineBorder: BorderSide(color: AppColors.textFieldBorderColor, width: 1),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldBorderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),

      /// Radio button
      radioTheme: const RadioThemeData(
        visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),

      /// Divider
      dividerTheme: const DividerThemeData(
        thickness: 1.5,
        color: CupertinoColors.systemGrey5,
      ),

      /// Floating action button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: AppColors.primaryColor,
        elevation: 2,
        iconSize: 36,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: AppColors.primaryColor,
        color: AppColors.primaryColor,
        refreshBackgroundColor: AppColors.primaryColor,
      ),

      ///AppBar theme
      appBarTheme: const AppBarTheme(centerTitle: true, backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent));
}
