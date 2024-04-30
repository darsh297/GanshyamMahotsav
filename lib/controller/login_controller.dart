import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/widgets/widgets.dart';

import '../network/api_config.dart';
import '../network/api_strings.dart';
import '../utils/app_colors.dart';
import '../view/otp_screen.dart';

class LoginController extends GetxController {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final Rx<TextEditingController> nameTextField = TextEditingController().obs;
  final Rx<TextEditingController> villageTextField = TextEditingController().obs;
  final Rx<TextEditingController> mobileTextField = TextEditingController().obs;
  RxBool isLoading = false.obs;

  Rx<Country> selectedCountry = Country(
    phoneCode: '254',
    countryCode: 'KE',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Kenya',
    example: '254123456789',
    displayName: 'Kenya (KE) [+254]',
    displayNameNoCountryCode: 'Kenya (KE)',
    e164Key: '254-KE-0',
  ).obs;

  /// Country select bottom sheet
  openCountryPickerDialog(BuildContext context) {
    showCountryPicker(
      context: context,
      // favorite: <String>['IN'],
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

  verifyNumber({required BuildContext context, required bool isLogin}) async {
    isLoading.value = true;
    try {
      var apiRes =
          await apiBaseHelper.postDataAPI(leadAPI: ApiStrings.kCheckPhoneNumber, isLogin: true, jsonObjectBody: {"phoneNumber": mobileTextField.value.text});
      GlobalResponse globalResponse = GlobalResponse.fromJson(apiRes);

      if (globalResponse.status == 200) {
        if (isLogin) {
          if (globalResponse.data['exists']) {
            Get.to(
              () => OTPScreen(
                phoneNumber: mobileTextField.value.text,
                countryCode: selectedCountry.value.phoneCode,
                isExist: globalResponse.data['exists'],
              ),
            );
          } else {
            if (context.mounted) CustomWidgets.showCustomDialog(context, 'Registration', 'Please create your account first');
          }
        } else {
          if (globalResponse.data['exists']) {
            CustomWidgets.toastValidation(msg: 'Number is already registered');
          } else {
            Get.to(
              () => OTPScreen(
                phoneNumber: mobileTextField.value.text,
                countryCode: selectedCountry.value.phoneCode,
                fullName: nameTextField.value.text,
                isExist: globalResponse.data['exists'],
              ),
            );
          }
        }
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CustomWidgets.toastValidation(msg: '$e');
    }
  }
}
