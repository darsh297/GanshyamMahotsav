// import 'dart:ffi';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:sms_autofill/sms_autofill.dart';

import '../controller/login_controller.dart';
import '../utils/app_colors.dart';
import '../utils/string_utils.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/widgets.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController loginController = Get.put(LoginController());
  final TextEditingController mobileNumber = TextEditingController();
  final _form = GlobalKey<FormState>();
  // Country currentCountry=Country(phoneCode: phoneCode, countryCode: countryCode, e164Sc: e164Sc, geographic: geographic, level: level, name: name, example: example, displayName: displayName, displayNameNoCountryCode: displayNameNoCountryCode, e164Key: e164Key)
  bool isOTP = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomPaint(
                painter: ShapesPainter(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Image.asset(StringUtils.logo, height: 140, width: double.infinity),
                ),
              ),
              const SizedBox(height: 30),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.textFieldBorderColor)),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        tabAlignment: TabAlignment.fill,
                        dividerHeight: 0,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColors.hintTextColor,
                        onTap: (int tabNumber) {
                          loginController.nameTextField.value.text = '';
                          loginController.passwordTextField.value.text = '';
                          loginController.mobileTextField.value.text = '';
                        },
                        tabs: const [
                          Tab(child: Text('Login')),
                          Tab(child: Text('Register')),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 350,
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: _form,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // isOTP
                                  //     ?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mobile No.',
                                        // style: appTextStyle.montserrat14W600,
                                      ),
                                      SizedBox(height: 4),
                                      CustomTextFields(
                                        textFieldController: mobileNumber,
                                        leadingIcon: InkWell(
                                          onTap: () {
                                            showCountryPicker(
                                              context: context,
                                              showPhoneCode: true, // optional. Shows phone code before the country name.
                                              onSelect: (Country country) {
                                                print('Select country: ${country.displayName}');
                                              },
                                            );
                                          },
                                          child: SizedBox(
                                            child: Row(children: [
                                              // Text('${}')
                                            ]),
                                          ),
                                        ),
                                      )
                                      // IntlPhoneField(
                                      //   decoration: InputDecoration(
                                      //     border: OutlineInputBorder(
                                      //       borderSide: BorderSide(),
                                      //     ),
                                      //   ),
                                      //   initialCountryCode: 'IN',
                                      //   onChanged: (phone) {
                                      //     print(phone);
                                      //   },
                                      // ),
                                    ],
                                  ),

                                  // : Pinput(
                                  //     // defaultPinTheme: defaultPinTheme,
                                  //     // focusedPinTheme: focusedPinTheme,
                                  //     // submittedPinTheme: submittedPinTheme,
                                  //     validator: (s) {
                                  //       return s == '2222' ? null : 'Pin is incorrect';
                                  //     },
                                  //     pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                  //     showCursor: true,
                                  //     onCompleted: (pin) => print(pin),
                                  //   ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Obx(
                                      () => loginController.isLoading.value
                                          ? loader
                                          : ElevatedButton(
                                              onPressed: () {
                                                final isValid = _form.currentState!.validate();
                                                if (isValid) {
                                                  // loginController.loginAPI();
                                                  Get.offAll(() => HomePage());
                                                }
                                              },
                                              child: Text(isOTP ? 'Get OTP' : 'Verify OTP'),
                                            ),
                                    ),
                                  ),

                                  // PinFieldAutoFill(
                                  //   codeLength: 6,
                                  //   // autoFocus: true,
                                  //   // decoration: UnderlineDecoration(
                                  //   //   lineHeight: 2,
                                  //   //   lineStrokeCap: StrokeCap.round,
                                  //   // bgColorBuilder: PinListenColorBuilder(AppColors.scaffoldColor, Colors.grey.shade200),
                                  //   // colorBuilder: const FixedColorBuilder(Colors.transparent),
                                  //   // ),
                                  // ),
                                  // SizedBox(
                                  //   width: double.infinity,
                                  //   child: Obx(
                                  //     () => loginController.isLoading.value
                                  //         ? loader
                                  //         : ElevatedButton(
                                  //             onPressed: () {
                                  //               final isValid = _form.currentState!.validate();
                                  //               if (isValid) {
                                  //                 // loginController.loginAPI();
                                  //                 Get.offAll(() => HomePage());
                                  //               }
                                  //             },
                                  //             child: const Text('Ver'),
                                  //           ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextFields(
                                  textFieldController: loginController.nameTextField.value,
                                  textFieldName: 'Name',
                                ),
                                CustomTextFields(
                                  textFieldController: loginController.mobileTextField.value,
                                  textFieldName: 'Mobile or Email ID',
                                ),
                                CustomTextFields(
                                  textFieldController: loginController.passwordTextField.value,
                                  textFieldName: 'Password',
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => loginController.registrationAPI(),
                                    child: const Text('Register'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const double _kCurveHeight = 35;

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.lineTo(0, size.height - _kCurveHeight);
    p.relativeQuadraticBezierTo(size.width / 2, 2 * _kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(p, Paint()..color = AppColors.scaffoldColor);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
