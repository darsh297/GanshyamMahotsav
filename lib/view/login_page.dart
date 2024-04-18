import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controller/login_controller.dart';
import '../utils/app_colors.dart';
import '../utils/string_utils.dart';
import '../utils/validations.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/widgets.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController loginController = Get.put(LoginController());
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController otpEditingController = TextEditingController();
  final _form = GlobalKey<FormState>();

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
                  child: Image.asset(StringUtils.logo, height: 190, width: double.infinity),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Form(
                                  key: _form,
                                  child: CustomTextFields(
                                    textFieldName: 'Mobile No.',
                                    hintText: 'Enter Mobile No.',
                                    textFieldController: mobileNumber,
                                    textInputType: TextInputType.number,
                                    validator: (input) {
                                      var result = ValidationsFunction.phoneValidation(input ?? '');
                                      return result.$1;
                                    },
                                    leadingIcon: SizedBox(
                                      width: 90,
                                      child: InkWell(
                                          onTap: () => loginController.openCountryPickerDialog(context),
                                          child: Obx(
                                            () {
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(loginController.selectedCountry.value.flagEmoji),
                                                  Text('+${loginController.selectedCountry.value.phoneCode} '), // style: appTextStyle.montserrat16W600
                                                  Text('| '),
                                                ],
                                              );
                                            },
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                                  child: TextButton(
                                      onPressed: () {
                                        loginController.isOTP.value = true;
                                      },
                                      child: const Text('Get OTP')),
                                ),
                                Obx(
                                  () => PinCodeTextField(
                                    appContext: context,
                                    controller: otpEditingController,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    enabled: loginController.isOTP.value ? true : false,
                                    length: 6,
                                    cursorColor: Colors.transparent,
                                    keyboardType: TextInputType.number,
                                    autoFocus: false,
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      selectedColor: AppColors.primaryColor,
                                      inactiveColor: AppColors.textFieldBorderColor,
                                      activeColor: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                      fieldHeight: 45,
                                      fieldWidth: 45,
                                      activeBorderWidth: 1.2,
                                      inactiveBorderWidth: 0.8,
                                      disabledBorderWidth: 1.2,
                                      errorBorderWidth: 1.2,
                                      selectedBorderWidth: 1.2,
                                      borderWidth: 1.2,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: double.infinity,
                                  child: Obx(
                                    () => loginController.isLoading.value
                                        ? loader
                                        : Obx(
                                            () => ElevatedButton(
                                              onPressed: loginController.isOTP.value
                                                  ? () {
                                                      final isValid = _form.currentState!.validate();
                                                      if (isValid) {
                                                        Get.offAll(() => HomePage());
                                                      }
                                                    }
                                                  : null,
                                              child: const Text('Verify OTP'),
                                            ),
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
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFields(
                                  textFieldController: loginController.nameTextField.value,
                                  textFieldName: 'Full Name',
                                ),
                                SizedBox(height: 8),
                                CustomTextFields(
                                  textFieldName: 'Mobile No.',
                                  hintText: 'Enter Mobile No.',
                                  textFieldController: mobileNumber,
                                  textInputType: TextInputType.number,
                                  validator: (input) {
                                    var result = ValidationsFunction.phoneValidation(input ?? '');
                                    return result.$1;
                                  },
                                  leadingIcon: SizedBox(
                                    width: 90,
                                    child: InkWell(
                                        onTap: () => loginController.openCountryPickerDialog(context),
                                        child: Obx(
                                          () {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(loginController.selectedCountry.value.flagEmoji),
                                                Text('+${loginController.selectedCountry.value.phoneCode} '), // style: appTextStyle.montserrat16W600
                                                Text('| '),
                                              ],
                                            );
                                          },
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                                  child: TextButton(
                                      onPressed: () {
                                        loginController.isOTP.value = true;
                                      },
                                      child: const Text('Get OTP')),
                                ),
                                PinCodeTextField(
                                  appContext: context,
                                  controller: otpEditingController,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  enabled: loginController.isOTP.value ? true : false,
                                  length: 6,
                                  cursorColor: Colors.transparent,
                                  keyboardType: TextInputType.number,
                                  autoFocus: false,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    selectedColor: AppColors.primaryColor,
                                    inactiveColor: AppColors.textFieldBorderColor,
                                    activeColor: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                    fieldHeight: 45,
                                    fieldWidth: 45,
                                    activeBorderWidth: 1.2,
                                    inactiveBorderWidth: 0.8,
                                    disabledBorderWidth: 1.2,
                                    errorBorderWidth: 1.2,
                                    selectedBorderWidth: 1.2,
                                    borderWidth: 1.2,
                                  ),
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
