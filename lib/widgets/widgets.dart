import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CustomWidgets {
  static toastValidation({required String msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static Widget loader = const Center(child: CircularProgressIndicator());

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
}
