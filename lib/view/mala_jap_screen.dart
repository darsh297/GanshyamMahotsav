import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/malajap_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';

import '../utils/widgets.dart';

class MalaJapScreen extends StatefulWidget {
  const MalaJapScreen({super.key});

  @override
  _MalaJapScreenState createState() => _MalaJapScreenState();
}

class _MalaJapScreenState extends State<MalaJapScreen> {
  MalaJapController malaJapController = Get.put(MalaJapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: const Text('Mala Jap'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.asset(
                    'assets/mala_jap_logo.jpg',
                    height: 250,
                  ),
                ),
                Obx(() => Text('${malaJapController.progress.value}', style: malaJapController.appTextStyle.montserrat28W700)),
                Obx(() => Text('Swaminarayan',
                    style: malaJapController.appTextStyle.montserrat28W700
                        .copyWith(color: malaJapController.isEnabled.value ? AppColors.grey1 : AppColors.primaryColor))),
                Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: DotPainter(dots: malaJapController.dots),
                      ),
                    ),
                    GestureDetector(
                      onTap: malaJapController.updateProgress,
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
      ),
    );
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
      final double angle = (2 * pi / 108) * i;
      final double x = radius + radius * cos(angle);
      final double y = radius + radius * sin(angle);
      if (dots[i]) {
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
