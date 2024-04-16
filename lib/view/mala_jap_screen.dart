import 'dart:math';

import 'package:flutter/material.dart';

class MalaJapScreen extends StatefulWidget {
  @override
  _MalaJapScreenState createState() => _MalaJapScreenState();
}

class _MalaJapScreenState extends State<MalaJapScreen> {
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plus Button with Progress'),
      ),
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  progress = (progress + 1) % 108; // Increment progress
                });
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
            CustomPaint(
              size: Size(200, 200),
              painter: ProgressPainter(progress: progress),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final int progress;

  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 108; i++) {
      final double angle = (2 * pi / 108) * i;
      final double x = radius + radius * cos(angle);
      final double y = radius + radius * sin(angle);
      if (i < progress) {
        paint.color = Colors.blue; // Change color for completed dots
      } else {
        paint.color = Colors.grey; // Color for remaining dots
      }
      canvas.drawCircle(Offset(x, y), 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
