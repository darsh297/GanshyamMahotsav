import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controller/otp_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/widgets.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;

  const OTPScreen({super.key, required this.phoneNumber, required this.countryCode});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final AppTextStyle appTextStyle = AppTextStyle();
  TextEditingController otpEditingController = TextEditingController();
  OTPController otpController = Get.put(OTPController());

  @override
  void initState() {
    super.initState();
    otpCall();
  }

  otpCall() {
    otpController.sendOTP('+${widget.countryCode}${widget.phoneNumber}');
  }

  @override
  void dispose() {
    otpController.timer?.value.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: Column(
                      children: [
                        // CircleAvatar(
                        //   radius: 38,
                        //   backgroundColor: AppColors.primaryColor,
                        //   child: Image.asset(
                        //     ImagePath.lock,
                        //     height: 40,
                        //     width: 26,
                        //     cacheHeight: 120,
                        //     cacheWidth: 78,
                        //   ),
                        // ),
                        const SizedBox(height: 28),
                        Text(
                          'Enter Verification code',
                          style: appTextStyle.montserrat22W700,
                        ),
                        const SizedBox(height: 6),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            // style: appTextStyle.montserrat12W500,
                            text: 'Input the code we sent to ',
                            children: <InlineSpan>[
                              TextSpan(
                                text: '+${widget.countryCode}-${widget.phoneNumber}',
                                // style: appTextStyle.montserrat12W600green,
                              ),
                              TextSpan(
                                // style: appTextStyle.montserrat12W500,
                                text: ' to access your account.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Enter Code Here',
                          // style: appTextStyle.montserrat14W600,
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: PinCodeTextField(
                            appContext: context,
                            controller: otpEditingController,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            length: 6,
                            cursorColor: Colors.transparent,
                            keyboardType: TextInputType.number,
                            autoFocus: true,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              selectedColor: AppColors.primaryColor,
                              inactiveColor: AppColors.textFieldBorderColor,
                              activeColor: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(4),
                              fieldHeight: 40,
                              fieldWidth: 40,
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
                            () => otpController.verifyOtpLoader.value
                                ? Container(
                                    decoration: BoxDecoration(color: AppColors.scaffoldColor, borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                      backgroundColor: AppColors.scaffoldColor,
                                    )),
                                  )
                                : ElevatedButton(
                                    onPressed: () => otpEditingController.text != ''
                                        ? otpController.verifyOTP(
                                            context: context,
                                            otp: otpEditingController.text,
                                            phoneNumber: widget.phoneNumber,
                                            countryCode: widget.countryCode,
                                          )
                                        : null,
                                    child: const Text('Verify Now'),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                otpController.resendOTP.value ? otpController.resetTimer('+${widget.countryCode}${widget.phoneNumber}') : null;
                              },
                              child: Obx(
                                () => Text('Resend Code',
                                    style: otpController.resendOTP.value
                                        ? appTextStyle.montserrat14W500
                                        : appTextStyle.montserrat14W500.copyWith(color: AppColors.grey)),
                              ),
                            ),
                            Obx(
                              () => Text(
                                '(0:${otpController.start.value})',
                                style: appTextStyle.montserrat16W700Green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => otpController.sendOtpLoader.value
                  ? Container(
                      color: AppColors.lightBorder.withOpacity(0.8),
                      child: CustomWidgets.loader,
                    )
                  : const SizedBox(height: 0, width: 0),
            ),
          ],
        ),
      ),
    );
  }
}