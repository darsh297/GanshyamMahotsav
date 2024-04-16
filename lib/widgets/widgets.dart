import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastValidation({required String msg}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
  );
}

Widget loader = const Center(child: CircularProgressIndicator());
