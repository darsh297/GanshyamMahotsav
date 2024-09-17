// import 'dart:math';
//
// import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:ghanshyam_mahotsav/controller/home_controller.dart';
// import 'package:ghanshyam_mahotsav/controller/malajap_controller.dart';
// import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
// import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';
//
// import '../utils/string_utils.dart';
// import '../widgets/widgets.dart';
//
// class MalaJapScreen extends StatefulWidget {
//   const MalaJapScreen({super.key});
//
//   @override
//   State<MalaJapScreen> createState() => _MalaJapScreenState();
// }
//
// class _MalaJapScreenState extends State<MalaJapScreen> {
//   MalaJapController malaJapController = Get.find();
//   HomeController homeController = Get.find();
//   AppTextStyle appTextStyle = AppTextStyle();
//
//   @override
//   void initState() {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     precacheImage(AssetImage(StringUtils.malaJapLogo), context);
//     return SizedBox(
//       height: Get.height - 318,
//       width: Get.width,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Obx(
//                 () => Text(
//                   '${'Credit Score'.tr}${homeController.creditScore.value}',
//                   style: appTextStyle.inter12DarkGrey,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               ConfettiWidget(
//                 confettiController: malaJapController.controllerCenter,
//                 blastDirectionality: BlastDirectionality.explosive,
//                 shouldLoop: true,
//                 colors: [AppColors.primaryColor, AppColors.scaffoldColor, AppColors.grey3, AppColors.white, AppColors.grey],
//                 createParticlePath: drawStar,
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(120),
//                 child: Image.asset(
//                   StringUtils.malaJapLogo,
//                   height: 210,
//                 ),
//                 // child:  precacheImage(const AssetImage(“path_to_asset_image”), context),
//               ),
//               Obx(() => Text('${malaJapController.progress.value}', style: malaJapController.appTextStyle.montserrat28W700)),
//               Obx(() => Text('Swaminarayan'.tr,
//                   style: malaJapController.appTextStyle.montserrat22W700
//                       .copyWith(color: malaJapController.isEnabled.value ? AppColors.grey1 : AppColors.primaryColor))),
//               Stack(
//                 children: [
//                   Positioned.fill(
//                     child: CustomPaint(
//                       painter: DotPainter(dots: malaJapController.dots),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () => malaJapController.updateProgress(context),
//                     child: Obx(
//                       () => Container(
//                         margin: const EdgeInsets.all(20),
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: malaJapController.isEnabled.value ? AppColors.primaryColor : AppColors.grey1,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Center(
//                           child: Icon(
//                             Icons.add,
//                             color: Colors.white,
//                             size: 40,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Obx(
//             () => malaJapController.isLogin.value
//                 ? Container(
//                     color: AppColors.lightBorder.withOpacity(0.8),
//                     child: CustomWidgets.loader,
//                   )
//                 : const SizedBox(height: 0, width: 0),
//           ),
//         ],
//       ),
//     );
//     // );
//   }
//
//   /// A custom Path to paint stars.
//   Path drawStar(Size size) {
//     // Method to convert degree to radians
//     double degToRad(double deg) => deg * (pi / 180.0);
//
//     const numberOfPoints = 5;
//     final halfWidth = size.width / 2;
//     final externalRadius = halfWidth;
//     final internalRadius = halfWidth / 2.5;
//     final degreesPerStep = degToRad(360 / numberOfPoints);
//     final halfDegreesPerStep = degreesPerStep / 2;
//     final path = Path();
//     final fullAngle = degToRad(360);
//     path.moveTo(size.width, halfWidth);
//
//     for (double step = 0; step < fullAngle; step += degreesPerStep) {
//       path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
//       path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep), halfWidth + internalRadius * sin(step + halfDegreesPerStep));
//     }
//     path.close();
//     return path;
//   }
// }
//
// class DotPainter extends CustomPainter {
//   final List<bool> dots;
//
//   DotPainter({required this.dots});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double radius = size.width / 2;
//     final Paint paint = Paint()
//       ..color = Colors.grey // Set the default color
//       ..style = PaintingStyle.fill;
//
//     for (int i = 0; i < 108; i++) {
//       // Adjust the angle calculation to start from 12 o'clock
//       final double angle = (2 * pi / 108) * i - (pi / 2); // Subtract pi/2 to start from 12 o'clock
//       final double x = radius + radius * cos(angle);
//       final double y = radius + radius * sin(angle);
//       if (i < dots.length && dots[i]) {
//         // Check if i is within range of dots list
//         paint.color = Colors.red; // Change color for dots representing progress
//       } else {
//         paint.color = Colors.grey; // Reset color for other dots
//       }
//       canvas.drawCircle(Offset(x, y), 2, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/home_controller.dart';
import 'package:ghanshyam_mahotsav/controller/malajap_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';

import '../utils/string_utils.dart';
import '../widgets/widgets.dart';

class MalaJapScreen extends StatefulWidget {
  const MalaJapScreen({super.key});

  @override
  State<MalaJapScreen> createState() => _MalaJapScreenState();
}

class _MalaJapScreenState extends State<MalaJapScreen> {
  MalaJapController malaJapController = Get.find();
  HomeController homeController = Get.find();
  AppTextStyle appTextStyle = AppTextStyle();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(StringUtils.malaJapLogo), context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.58,
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  '${'Credit Score'.tr}${homeController.creditScore.value}',
                  style: appTextStyle.inter12DarkGrey,
                ),
              ),
              const SizedBox(height: 6),
              ConfettiWidget(
                confettiController: malaJapController.controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                colors: [
                  AppColors.primaryColor,
                  AppColors.scaffoldColor,
                  AppColors.grey3,
                  AppColors.white,
                  AppColors.grey
                ],
                createParticlePath: drawStar,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Image.asset(
                  StringUtils.malaJapLogo,
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                // child:  precacheImage(const AssetImage(“path_to_asset_image”), context),
              ),
              Obx(() => Text('${malaJapController.progress.value}',
                  style: malaJapController.appTextStyle.montserrat28W700)),
              Obx(() => Text('Swaminarayan'.tr,
                  style: malaJapController.appTextStyle.montserrat22W700
                      .copyWith(
                          color: malaJapController.isEnabled.value
                              ? AppColors.grey1
                              : AppColors.primaryColor))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        // Sound toggle logic here
                        malaJapController.isSoundOn.value = !malaJapController.isSoundOn.value;
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.all(20),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: malaJapController.isSoundOn.value
                                ? AppColors.primaryColor
                                : AppColors.grey1,
                            shape: BoxShape.circle,
                          ),
                          child:malaJapController.isSoundOn.value ?const Center(
                            child: Icon(
                              Icons.volume_up,
                              color: Colors.white,
                              size: 30,
                            ),
                          ) :const Center(
                            child: Icon(
                              Icons.volume_off,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: DotPainter(dots: malaJapController.dots),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => malaJapController.updateProgress(context),
                        child: Obx(
                          () => Container(
                            margin: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.height * 0.15,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              color: malaJapController.isEnabled.value
                                  ? AppColors.primaryColor
                                  : AppColors.grey1,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        // Vibration toggle logic here
                        malaJapController.isVibrationOn.value = !malaJapController.isVibrationOn.value;
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.all(20),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: malaJapController.isVibrationOn.value
                                ? AppColors.primaryColor
                                : AppColors.grey1,
                            shape: BoxShape.circle,
                          ),
                          child: malaJapController.isVibrationOn.value ? const Center(
                            child: Icon(
                              Icons.vibration,
                              color: Colors.white,
                              size: 30,
                            ),
                          ): const Center(
                            child: Icon(
                              Icons.vibration_sharp,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Obx(
            () => malaJapController.isLogin.value
                ? Container(
                    color: AppColors.lightBorder.withOpacity(0.8),
                    child: CustomWidgets.loader,
                  )
                : const SizedBox(height: 0, width: 0),
          ),
        ],
      ),
    );
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}

class DotPainter extends CustomPainter {
  final List<bool> dots;

  DotPainter({required this.dots});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Paint paint = Paint()
      ..color = Colors.grey // Set the default color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 108; i++) {
      final double angle = (2 * pi / 108) * i - (pi / 2);
      final double x = radius + radius * cos(angle);
      final double y = radius + radius * sin(angle);
      if (i < dots.length && dots[i]) {
        paint.color = Colors.red;
      } else {
        paint.color = Colors.grey;
      }
      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
