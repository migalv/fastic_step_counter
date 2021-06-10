import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgress extends StatelessWidget {
  final double value;
  const CircleProgress({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // To make it responsive I use the MediaQuery to find the size of the cirle
    final double circleSize = MediaQuery.of(context).size.width * 3 / 5;
    return CustomPaint(
      foregroundPainter: CircleProgressPainter(value),
      child: Center(
        child: SizedBox(
          height: circleSize,
          width: circleSize,
          child: Center(
            child: Text(
              "${value.toStringAsFixed(0)}%",
              style: const TextStyle(fontSize: 64.0),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  double value;

  CircleProgressPainter(this.value);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const int maximumValue = 100;
    const Color strokeColor = Color.fromRGBO(247, 165, 108, 1);
    const Color backgroundColor = Color.fromRGBO(166, 172, 180, 0.3);
    const double strokeWidth = 12.0;

    final Paint outerCircle = Paint()
      ..strokeWidth = strokeWidth
      ..color = backgroundColor
      ..style = PaintingStyle.stroke;

    final Paint tempArc = Paint()
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2) - strokeWidth;
    canvas.drawCircle(center, radius, outerCircle);

    final double angle = 2 * pi * (value / maximumValue);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      tempArc,
    );
  }
}
