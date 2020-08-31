import 'package:flutter/material.dart';

class Cup extends CustomPainter {
  double constant = 1;

  @override
  void paint(Canvas canvas, Size size) {
    Paint cupLiningPainter = Paint();
    cupLiningPainter.color = Colors.brown;
    cupLiningPainter.style = PaintingStyle.stroke;

    Paint waterPainter = Paint();
    waterPainter.color =
        Colors.lightBlueAccent; // TODO replace with water color
    waterPainter.style = PaintingStyle.fill;

    Path cupLiningPath = Path();

    cupLiningPath.moveTo(size.width * 0.15, size.height * 0.3);
    cupLiningPath.lineTo(size.width * 0.9, size.height * 0.3);
    cupLiningPath.lineTo(size.width * 0.75, size.height * 0.7);
    cupLiningPath.lineTo(size.width * 0.3, size.height * 0.7);
    cupLiningPath.lineTo(size.width * 0.15, size.height * 0.3);

    Path waterPath = Path();

    waterPath.moveTo(size.width * 0.154, size.height * 0.31 * constant);
    waterPath.quadraticBezierTo(
        size.width * 0.099,
        size.height * 0.315 * constant,
        size.width * 0.3375,
        size.height * 0.3 * constant);
    waterPath.quadraticBezierTo(
        size.width * 0.44,
        size.height * 0.302 * constant,
        size.width * 0.525,
        size.height * 0.31 * constant);
    waterPath.quadraticBezierTo(
        size.width * 0.61,
        size.height * 0.319 * constant,
        size.width * 0.7125,
        size.height * 0.32 * constant);
    waterPath.quadraticBezierTo(
        size.width * 0.815,
        size.height * 0.319 * constant,
        size.width * 0.895,
        size.height * 0.31 * constant);
    waterPath.lineTo(size.width * 0.75,size. height * 0.7);
    waterPath.lineTo(size.width * 0.3, size.height * 0.7);
    waterPath.lineTo(size.width * 0.154,size. height * 0.31 * constant);

    canvas.drawPath(cupLiningPath, cupLiningPainter);
    canvas.drawPath(waterPath, waterPainter);
  }

  bool decrease(double intake) {
    if (constant <= 2.2) {
      constant += intake;
      return true;
    }
    return false;
  }

  refill() {
    constant = 1;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
