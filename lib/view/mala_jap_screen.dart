import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';

class MalaJapScreen extends StatefulWidget {
  const MalaJapScreen({super.key});

  @override
  _MalaJapScreenState createState() => _MalaJapScreenState();
}

class _MalaJapScreenState extends State<MalaJapScreen> {
  int progress = 0;
  List<bool> dots = List.generate(108, (_) => false); // List to track dot colors

  void updateProgress() {
    setState(() {
      dots[progress] = true; // Update dot color
      progress = (progress + 1) % 108; // Increment progress
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: const Text('Mala Jap'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Stack(
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
                  color: AppColors.primaryColor,
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
