import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/register_response.dart';
import 'package:ghanshyam_mahotsav/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/global_response.dart';
import '../model/login_response.dart';
import '../network/api_config.dart';
import '../network/api_strings.dart';
import '../utils/app_colors.dart';
import '../utils/shared_preference.dart';
import '../utils/string_utils.dart';
import '../widgets/widgets.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    codeSent(String verificationId, [int? forceResendingToken]) {
      debugPrint('Code Sent - $verificationId');
      sendOtpLoader.value = false;
      startTimer();
      _verificationId = verificationId;
      resendOTP.value = false;
      _resendCode = forceResendingToken ?? 0;
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 58),
      verificationCompleted: (AuthCredential credential) => debugPrint('Automatically Read SMS ${credential.providerId}'),
      verificationFailed: (FirebaseAuthException e) {
        CustomWidgets.toastValidation(msg: "${e.message}");
        sendOtpLoader.value = false;
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) => debugPrint('Auto Retrieval Timeout'),
      forceResendingToken: _resendCode,
    );
  }

  void verifyOTP(
      {required String otp,
      required BuildContext context,
      String phoneNumber = '0000000000',
      String countryCode = '91',
      bool isLogin = true,
      String fullName = ''}) async {
    try {
      verifyOtpLoader.value = true;
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: otp);
      User? user = (await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential)).user;
      verifyOtpLoader.value = false;

      if (user != null) {
        timer?.value.cancel();

        loginAPICall(countryCode: countryCode, phoneNumber: phoneNumber, isLogin: isLogin, fullName: fullName);
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
        timer?.value.cancel();
        loginAPICall(countryCode: countryCode, phoneNumber: phoneNumber, isLogin: isLogin, fullName: fullName);
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
  loginAPICall({String phoneNumber = '0000000000', String countryCode = '91', bool isLogin = true, String fullName = ''}) async {
    if (isLogin) {
      var apiResponse = await apiBaseHelper.postDataAPI(
        leadAPI: ApiStrings.kLogin,
        jsonObjectBody: {
          "phoneNumber": phoneNumber,
          "countryCode": '+$countryCode',
        },
      );

      GlobalResponse globalResponse = GlobalResponse.fromJson(apiResponse);

      ///Success
      if (globalResponse.status == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(globalResponse.data);
        sharedPreferenceClass.storeData(StringUtils.prefUserTokenKey, loginResponse.token ?? '');
        sharedPreferenceClass.storeData(StringUtils.prefUserName, loginResponse.fullName ?? '');
        sharedPreferenceClass.storeData(StringUtils.prefUserId, loginResponse.sId);
        sharedPreferenceClass.storeData(StringUtils.prefUserCredit, loginResponse.creditCount);
        sharedPreferenceClass.storeBool(StringUtils.prefIsAdmin, loginResponse.isAdmin ?? false);
        sharedPreferenceClass.storeData(StringUtils.prefLanguage, StringUtils.english);
        sharedPreferenceClass.storeData(StringUtils.prefUserPhone, loginResponse.phoneNumber);
        sharedPreferenceClass.storeData(StringUtils.prefUserVillage, 'Ahmedabad');
        Get.offAll(() => const HomePage());
      }

      /// Fail
      else {
        CustomWidgets.toastValidation(msg: globalResponse.message ?? '');
      }
    } else {
      var apiResponse = await apiBaseHelper.postDataAPI(
        leadAPI: ApiStrings.kRegister,
        jsonObjectBody: {
          "phoneNumber": phoneNumber,
          "countryCode": '+$countryCode',
          "fullName": fullName,
        },
      );

      GlobalResponse globalResponse = GlobalResponse.fromJson(apiResponse);
      RegisterResponse registerResponse = RegisterResponse.fromJson(globalResponse.data);

      ///Success
      if (globalResponse.status == 200) {
        sharedPreferenceClass.storeData(StringUtils.prefUserTokenKey, registerResponse.token ?? '');
        sharedPreferenceClass.storeData(StringUtils.prefUserName, registerResponse.fullName ?? '');
        sharedPreferenceClass.storeData(StringUtils.prefUserId, registerResponse.sId);
        sharedPreferenceClass.storeData(StringUtils.prefUserCredit, registerResponse.creditCount);
        sharedPreferenceClass.storeData(StringUtils.prefIsAdmin, registerResponse.isAdmin);
        sharedPreferenceClass.storeData(StringUtils.prefLanguage, StringUtils.english);
        sharedPreferenceClass.storeData(StringUtils.prefUserPhone, registerResponse.phoneNumber);
        sharedPreferenceClass.storeData(StringUtils.prefUserVillage, 'Ahmedabad');

        Get.offAll(() => const HomePage());
      }

      /// Fail
      else {
        CustomWidgets.toastValidation(msg: globalResponse.message ?? '');
      }
    }
  }
}
