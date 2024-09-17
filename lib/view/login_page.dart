import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import '../utils/app_colors.dart';
import '../utils/string_utils.dart';
import '../utils/validations.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomPaint(
                    painter: ShapesPainter(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Hero(tag: 'logo', child: Image.asset(StringUtils.logo, height: 220, width: double.infinity)),
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
                              loginController.villageTextField.value.text = '';
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
                          height: 420,
                          child: TabBarView(
                            children: [
                              /// First Tab -> Login
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Login - Mobile textbox
                                    Form(
                                      key: _loginForm,
                                      child: CustomTextFields(
                                        textFieldName: 'Mobile No.',
                                        hintText: 'Enter Mobile No.',
                                        textFieldController: loginController.mobileTextField.value,
                                        textInputType: TextInputType.number,
                                        validator: (input) {
                                          var result = ValidationsFunction.phoneValidation(input ?? '');
                                          return result.$1;
                                        },
                                        leadingIcon: SizedBox(
                                          width: 103,
                                          child: InkWell(
                                              onTap: () => loginController.openCountryPickerDialog(context),
                                              child: Obx(
                                                () {
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(loginController.selectedCountry.value.flagEmoji),
                                                      Text('+${loginController.selectedCountry.value.phoneCode} '), // style: appTextStyle.montserrat16W600
                                                      const Text('| '),
                                                    ],
                                                  );
                                                },
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 26),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Obx(
                                        () => loginController.isLoading.value
                                            ? Container(
                                                padding: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(color: AppColors.scaffoldColor, borderRadius: BorderRadius.circular(5)),
                                                child: CustomWidgets.loader,
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  final isValid = _loginForm.currentState!.validate();
                                                  if (isValid) {
                                                    loginController.verifyNumber(context: context, isLogin: true);
                                                  }
                                                },
                                                child: const Text('Get OTP'),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// Send Tab -> Register
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Form(
                                  key: _registerForm,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTextFields(
                                        textFieldController: loginController.nameTextField.value,
                                        textFieldName: 'Full Name',
                                        validator: (input) {
                                          var result = ValidationsFunction.textValidation(input ?? '');
                                          return result.$1;
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      CustomTextFields(
                                        fromLogin: true,
                                        textFieldController: loginController.villageTextField.value,
                                        textFieldName: 'Village',
                                        validator: (input) {
                                          var result = ValidationsFunction.textValidation(input ?? '');
                                          return result.$1;
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      CustomTextFields(
                                        textFieldName: 'Mobile No.',
                                        hintText: 'Enter Mobile No.',
                                        textFieldController: loginController.mobileTextField.value,
                                        textInputType: TextInputType.number,
                                        validator: (input) {
                                          var result = ValidationsFunction.phoneValidation(input ?? '');
                                          return result.$1;
                                        },
                                        leadingIcon: SizedBox(
                                          width: 103,
                                          child: InkWell(
                                            onTap: () => loginController.openCountryPickerDialog(context),
                                            child: Obx(
                                              () {
                                                return Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(loginController.selectedCountry.value.flagEmoji),
                                                    Text('+${loginController.selectedCountry.value.phoneCode} '), // style: appTextStyle.montserrat16W600
                                                    const Text('| '),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 22),

                                      /// Register button
                                      SizedBox(
                                        width: double.infinity,
                                        child: Obx(
                                          () => loginController.isLoading.value
                                              ? Container(
                                                  padding: const EdgeInsets.all(2),
                                                  decoration: BoxDecoration(color: AppColors.scaffoldColor, borderRadius: BorderRadius.circular(5)),
                                                  child: CustomWidgets.loader,
                                                )
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    final isValid = _registerForm.currentState!.validate();
                                                    if (isValid) {
                                                      loginController.verifyNumber(context: context, isLogin: false);
                                                    }
                                                  },
                                                  child: const Text('Register'),
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
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
            // Obx(
            //   () => loginController.isLoading.value
            //       ? Container(
            //           color: AppColors.lightBorder.withOpacity(0.8),
            //           child: CustomWidgets.loader,
            //         )
            //       : const SizedBox(height: 0, width: 0),
            // ),
          ],
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
