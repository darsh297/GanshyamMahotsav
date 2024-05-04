import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';

import '../utils/app_text_styles.dart';
import '../utils/shared_preference.dart';
import '../utils/string_utils.dart';

class MalaJapController extends GetxController {
  final RxInt progress = 0.obs;
  final RxList<bool> dots = List.generate(108, (_) => false).obs; // List to track dot colors
  final AppTextStyle appTextStyle = AppTextStyle();
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final RxBool isEnabled = true.obs;
  final RxBool isLogin = false.obs;

  Future<void> updateProgress(context) async {
    if (isEnabled.value) {
      isEnabled.value = false;

      // Enable button after 1 seconds
      Timer(const Duration(seconds: 1), () {
        isEnabled.value = true;
      });

      dots[progress.value] = true; // Update dot color
      progress.value = (progress.value + 1) % 108; // Increment progress

      if (progress.value == 3) {
        isLogin.value = true;
        var apiRes = await apiBaseHelper.getData(leadAPI: ApiStrings.kAddCredits);
        GlobalResponse globalResponse = GlobalResponse.fromJson(apiRes);
        isLogin.value = false;
        if (globalResponse.status == 200) {
          SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
          await sharedPreferenceClass.incrementCredit(StringUtils.prefUserCredit);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Congratulation'),
                  content: const Text('1 more Credit added!!!'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Okay'),
                    ),
                  ],
                );
              });
          // CustomWidgets.toastValidation(msg: 'New Credits added');
          progress.value = 0;
          dots.assignAll(List.generate(108, (_) => false));
        }
      }
    }
  }
}
