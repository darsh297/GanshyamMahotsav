import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_colors.dart';

class CustomWidgets {
  static List<BoxShadow>? boxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      spreadRadius: 0,
      blurRadius: 3,
      offset: const Offset(0, 1.5),
    ),
  ];

  // static Widget menuLeadingIcon = Image.asset(
  //   ImagePath.drawerIcon,
  //   height: 14,
  //   width: 24,
  //   cacheWidth: 72,
  //   cacheHeight: 42,
  // );

  // static Widget filterIcon = Image.asset(
  //   ImagePath.filter,
  //   height: 18,
  //   width: 20,
  // );
  // static Widget searchIcon = Image.asset(
  //   ImagePath.search,
  //   height: 18,
  //   width: 20,
  // );

  static toastValidation({required String msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static Widget loader = Center(child: LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 40));
}
