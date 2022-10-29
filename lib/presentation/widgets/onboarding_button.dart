import 'dart:math';

import 'package:flutter/material.dart';

class CircularBorder extends StatelessWidget {
  const CircularBorder(
      {super.key,
      this.color = Colors.blue,
      this.size = 70,
      this.width = 5.0,
      required this.icon});
  final Color color;
  final double size;
  final double width;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          icon,
          CustomPaint(
            size: Size(size, size),
            foregroundPainter: MyPainter(completeColor: color, width: width),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter({required this.completeColor, required this.width});
  Color lineColor = Colors.transparent;
  Color completeColor;
  double width;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);
    final double percent = (size.width * 0.001) / 2;

    final double arcAngle = 2 * pi * percent;
    // print("$radius - radius");
    // print("$arcAngle - arcAngle");
    // print("${radius / arcAngle} - divider");

    for (int i = 0; i < 8; i++) {
      final double init = (-pi / 2) * (i / 2);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        init,
        arcAngle,
        false,
        complete,
      );
      // if (i % 2 == 0) {
      // } else {
      //   canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
      //       init, arcAngle, false, current);
      // }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
