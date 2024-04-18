import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/view/home_page.dart';

import '../network/api_config.dart';
import '../network/api_strings.dart';
import '../utils/app_colors.dart';
import '../utils/shared_preference.dart';

class OTPController extends GetxController {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  RxInt start = 60.obs;
  RxBool resendOTP = false.obs;
  final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
  Rx<Timer>? timer = Timer(const Duration(seconds: 1), () {}).obs;
  late String _verificationId;
  int? _resendCode;
  RxBool sendOtpLoader = true.obs;
  RxBool verifyOtpLoader = false.obs;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer?.value = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
          resendOTP.value = true;
        } else {
          start.value--;
        }
      },
    );
  }

  void resetTimer(phoneNumber) {
    start.value = 60;
    timer?.value.cancel();
    sendOTP(phoneNumber);
  }

  void sendOTP(phoneNumber) async {
    Future.delayed(
      const Duration(seconds: 6),
      () {
        sendOtpLoader.value = false;
        startTimer();
      },
    );
    // codeSent(String verificationId, [int? forceResendingToken]) {
    //   debugPrint('Code Sent - $verificationId');
    //   sendOtpLoader.value = false;
    //   startTimer();
    //   _verificationId = verificationId;
    //   resendOTP.value = false;
    //   _resendCode = forceResendingToken ?? 0;
    // }

    // await _auth.verifyPhoneNumber(
    //   phoneNumber: phoneNumber,
    //   timeout: const Duration(seconds: 58),
    //   verificationCompleted: (AuthCredential credential) => debugPrint('Automatically Read SMS ${credential.providerId}'),
    //   verificationFailed: (FirebaseAuthException e) {
    //     CustomWidgets.toastValidation(msg: "${e.message}");
    //     sendOtpLoader.value = false;
    //   },
    //   codeSent: codeSent,
    //   codeAutoRetrievalTimeout: (String verificationId) => debugPrint('Auto Retrieval Timeout'),
    //   forceResendingToken: _resendCode,
    // );
  }

  void verifyOTP({required String otp, required BuildContext context, String phoneNumber = '0000000000', String countryCode = '91'}) async {
    try {
      verifyOtpLoader.value = true;
      // String? token = await FirebaseMessaging.instance.getToken();
      // PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: otp);
      // User? user = (await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential)).user;
      verifyOtpLoader.value = false;
      if (otp == '123456') {
        Get.to(() => HomePage());

        // if (user != null) {
        //   timer?.value.cancel();
        //   loginAPICall(countryCode: countryCode, phoneNumber: phoneNumber, deviceToken: token ?? '');
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("The code was entered incorrectly"),
            showCloseIcon: true,
            backgroundColor: AppColors.redColor,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          ),
        );
      }
    } catch (e) {
      verifyOtpLoader.value = false;
      if (!context.mounted) return;
      if (otp == '123456') {
        //String? token = await FirebaseMessaging.instance.getToken();
        String? token = "fdjfkgdjfgdhfgjdgdlfgdfgjdfhgjghldjfgffd";

        timer?.value.cancel();
        loginAPICall(countryCode: countryCode, phoneNumber: phoneNumber, deviceToken: token);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("The code was entered incorrectly"),
            showCloseIcon: true,
            backgroundColor: AppColors.redColor,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          ),
        );
      }
    }
  }

  /// Verify number API call - to get User device token- after verified OTP
  loginAPICall({String phoneNumber = '0000000000', String countryCode = '91', String deviceToken = 'String'}) async {
    var apiResponse = await apiBaseHelper.postDataAPI(
      leadAPI: ApiStrings.kLogin,
      jsonObjectBody: {
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "device_token": deviceToken,
        "device_type": "1",
      },
    );
    //
    // GlobalResponse globalResponse = GlobalResponse.fromJson(apiResponse);
    // late LoginResponse loginResponse;
    // if (globalResponse.payload != null) {
    //   loginResponse = LoginResponse.fromJson(globalResponse.payload);
    // }

    ///Success
    // if (globalResponse.status == 200) {
    // sharedPreferenceClass.storeData(StringUtils.prefUserTokenKey, loginResponse.token);
    // sharedPreferenceClass.storeData(StringUtils.prefUserName, '${loginResponse.userData?.firstName} ${loginResponse.userData?.lastName}');
    // sharedPreferenceClass.storeData(StringUtils.prefUserProfileURL, loginResponse.userData?.profileImg);
    // sharedPreferenceClass.storeData(StringUtils.prefUserId, loginResponse.userData?.userId);
    Get.offAll(() => HomePage());
    // }

    /// Fail
    // else {
    //   CustomWidgets.toastValidation(msg: globalResponse.message ?? '');
    // }
  }
}
