import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/malajap_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';

import '../utils/string_utils.dart';
import '../widgets/widgets.dart';

class MalaJapScreen extends StatefulWidget {
  const MalaJapScreen({super.key});

  @override
  State<MalaJapScreen> createState() => _MalaJapScreenState();
}

class _MalaJapScreenState extends State<MalaJapScreen> {
  MalaJapController malaJapController = Get.find();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(StringUtils.malaJapLogo), context);
    return SizedBox(
      height: Get.height - 320,
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConfettiWidget(
                confettiController: malaJapController.controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                colors: [AppColors.primaryColor, AppColors.scaffoldColor, AppColors.grey3, AppColors.white, AppColors.grey],
                createParticlePath: drawStar,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Image.asset(
                  StringUtils.malaJapLogo,
                  height: 250,
                ),
                // child:  precacheImage(const AssetImage(“path_to_asset_image”), context),
              ),
              Obx(() => Text('${malaJapController.progress.value}', style: malaJapController.appTextStyle.montserrat28W700)),
              Obx(() => Text('Swaminarayan'.tr,
                  style: malaJapController.appTextStyle.montserrat22W700
                      .copyWith(color: malaJapController.isEnabled.value ? AppColors.grey1 : AppColors.primaryColor))),
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
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: malaJapController.isEnabled.value ? AppColors.primaryColor : AppColors.grey1,
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
    // );
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
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
      path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep), halfWidth + internalRadius * sin(step + halfDegreesPerStep));
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
      // Change the loop limit to 109
      final double angle = (2 * pi / 108) * i; // Adjust for 109 dots
      final double x = radius + radius * cos(angle);
      final double y = radius + radius * sin(angle);
      if (i < dots.length && dots[i]) {
        // Check if i is within range of dots list
        paint.color = Colors.red; // Change color for dots representing progress
      } else {
        paint.color = Colors.grey; // Reset color for other dots
      }
      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
