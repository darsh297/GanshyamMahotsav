import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../network/api_config.dart';
import '../network/api_strings.dart';

class LoginController extends GetxController {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final Rx<TextEditingController> nameTextField = TextEditingController().obs;
  final Rx<TextEditingController> passwordTextField = TextEditingController().obs;
  final Rx<TextEditingController> mobileTextField = TextEditingController().obs;
  RxBool isLoading = false.obs;

  /// Login API call
  loginAPI() async {
    isLoading.value = true;
    var apiResponse = await apiBaseHelper.postDataAPI(
      leadAPI: ApiStrings.kLogin,
      jsonObjectBody: {"mobileNumber": mobileTextField.value.text, "password": passwordTextField.value.text},
    );
    isLoading.value = false;
    print('1111 $apiResponse');
    // GlobalResponse globalResponse = GlobalResponse.fromJson(apiResponse);
    //
    // if (globalResponse.status == 200) {
    //   Get.to(() => OTPScreen(phoneNumber: phoneNumber, countryCode: countryCode));
    // } else {
    //   toastValidation(msg: globalResponse.message ?? '');
    // }
  }

  ///Registration API call
  registrationAPI() async {
    isLoading.value = true;
    var apiResponse = await apiBaseHelper.postDataAPI(
      leadAPI: ApiStrings.kLogin,
      jsonObjectBody: {"name": nameTextField.value.text, "mobileNumber": mobileTextField.value.text, "password": passwordTextField.value.text},
    );
    isLoading.value = false;
    print('2222 $apiResponse');
    // GlobalResponse globalResponse = GlobalResponse.fromJson(apiResponse);
    //
    // if (globalResponse.status == 200) {
    //   Get.to(() => OTPScreen(phoneNumber: phoneNumber, countryCode: countryCode));
    // } else {
    //   toastValidation(msg: globalResponse.message ?? '');
    // }
  }
}
