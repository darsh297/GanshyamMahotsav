import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';

class MalaJapScreen extends StatefulWidget {
  const MalaJapScreen({super.key});

  @override
  _MalaJapScreenState createState() => _MalaJapScreenState();
}

class _MalaJapScreenState extends State<MalaJapScreen> {
  int progress = 0;
  List<bool> dots = List.generate(108, (_) => false); // List to track dot colors
  AppTextStyle appTextStyle = AppTextStyle();

  bool _isEnabled = true;

  void updateProgress() {
    if (_isEnabled) {
      // Disable button
      setState(() {
        _isEnabled = false;
      });

      // Enable button after 30 seconds
      Timer(const Duration(seconds: 2), () {
        setState(() {
          _isEnabled = true;
        });
      });

      setState(() {
        dots[progress] = true; // Update dot color
        progress = (progress + 1) % 108; // Increment progress
      });
      print('Button clicked!');
    }
  }

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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              'https://www.swaminarayan.faith/media/2449/mahraj-writting-a-letter.jpg?anchor=center&mode=crop&width=400&height=300&rnd=132019680760000000',
              // width: ,
            ),
            Text('$progress', style: appTextStyle.montserrat28W700),
            Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: DotPainter(dots: dots),
                  ),
                ),
                GestureDetector(
                  onTap: updateProgress,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _isEnabled ? AppColors.primaryColor : AppColors.grey1,
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
              ],
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
