import 'dart:async';

import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';
import 'package:ghanshyam_mahotsav/utils/widgets.dart';

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

  Future<void> updateProgress() async {
    if (isEnabled.value) {
      isEnabled.value = false;

      // Enable button after 1 seconds
      Timer(const Duration(seconds: 1), () {
        isEnabled.value = true;
      });

      dots[progress.value] = true; // Update dot color
      progress.value = (progress.value + 1) % 108; // Increment progress

      if (progress.value == 108) {
        isLogin.value = true;
        var apiRes = await apiBaseHelper.getData(leadAPI: ApiStrings.kAddCredits);
        GlobalResponse globalResponse = GlobalResponse.fromJson(apiRes);
        isLogin.value = false;
        if (globalResponse.status == 200) {
          SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
          await sharedPreferenceClass.incrementCredit(StringUtils.prefUserCredit);
          CustomWidgets.toastValidation(msg: 'New Credits added');
          progress.value = 0;
          dots.assignAll(List.generate(108, (_) => false));
        }
      }
    }
  }
}
