import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';
import 'package:vibration/vibration.dart';

import '../utils/app_text_styles.dart';
import '../utils/shared_preference.dart';
import '../utils/string_utils.dart';
import 'home_controller.dart';

class MalaJapController extends GetxController {
  final RxInt progress = 0.obs;
  final RxList<bool> dots = List.generate(108, (_) => false).obs; // List to track dot colors
  final AppTextStyle appTextStyle = AppTextStyle();
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final RxBool isEnabled = true.obs;
  final RxBool isLogin = false.obs;
  final ConfettiController controllerCenter = ConfettiController(duration: const Duration(seconds: 10));
  final HomeController homeController = Get.find();

  Future<void> updateProgress(context) async {
    if (isEnabled.value) {
      Vibration.vibrate(amplitude: 100, duration: 100);
      // isEnabled.value = false;

      Clipboard.setData(const ClipboardData(text: ''));
      HapticFeedback.vibrate();
      // Enable button after 1 seconds
      Timer(const Duration(seconds: 1), () {
        isEnabled.value = true;
      });
      AudioPlayer player = AudioPlayer();
      await player.setSource(AssetSource('audio.mp3'));
      player.resume();
      Timer(const Duration(seconds: 1), () {
        player.stop();
      });
      dots[progress.value] = true; // Update dot color
      progress.value = (progress.value + 1) % 108; // Increment progress
      print('||| ${progress.value}');
      if (progress.value == 0) {
        progress.value = 108;
        isLogin.value = true;
        var apiRes = await apiBaseHelper.getData(leadAPI: ApiStrings.kAddCredits);
        GlobalResponse globalResponse = GlobalResponse.fromJson(apiRes);
        isLogin.value = false;
        if (globalResponse.status == 200) {
          SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
          await sharedPreferenceClass.incrementCredit(StringUtils.prefUserCredit);
          homeController.creditScore.value += 1;
          controllerCenter.play();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Congratulation'.tr),
                  content: Text('Jay Shree Swaminarayan Your Mala hasp completed.'.tr),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                        controllerCenter.stop();
                      },
                      child: Text('Okay'.tr),
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
