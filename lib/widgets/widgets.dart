import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_colors.dart';

class CustomWidgets {
  static toastValidation({required String msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void showCustomDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static List<BoxShadow>? boxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      spreadRadius: 0,
      blurRadius: 3,
      offset: const Offset(0, 1.5),
    ),
  ];

  static Future<bool> isNetworkAvailable() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    for (var element in connectivityResult) {
      debugPrint("element $element");
    }
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    } else {
      return false;
    }
  }

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

  static Widget loader = Center(child: LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 40));
}
