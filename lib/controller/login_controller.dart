import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../network/api_config.dart';
import '../network/api_strings.dart';
import '../utils/app_colors.dart';

class LoginController extends GetxController {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final Rx<TextEditingController> nameTextField = TextEditingController().obs;
  final Rx<TextEditingController> passwordTextField = TextEditingController().obs;
  final Rx<TextEditingController> mobileTextField = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxBool isOTP = false.obs;

  Rx<Country> selectedCountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: '9123456789',
    displayName: 'India (IN) [+91]',
    displayNameNoCountryCode: 'India (IN)',
    e164Key: '91-IN-0',
  ).obs;

  /// Country select bottom sheet
  openCountryPickerDialog(BuildContext context) {
    showCountryPicker(
      context: context,
      favorite: <String>['IN'],
      showPhoneCode: true,
      onSelect: (Country country) => selectedCountry.value = country,
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        bottomSheetHeight: 700,
        padding: const EdgeInsets.only(top: 20),
        inputDecoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search, color: AppColors.hintTextColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }

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
