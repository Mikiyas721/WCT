import 'package:flutter/material.dart';

class Cup extends CustomPainter {
  double constant = 1;

  Cup({double intake, bool refill}) {
    /* if (refill != null && refill)
      constant = 1;
    else {
      if (constant <= 2.2) {
        constant += intake;
      }
    }*/
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint cupLiningPainter = Paint();
    cupLiningPainter.color = Colors.brown;
    cupLiningPainter.style = PaintingStyle.stroke;

    Paint waterPainter = Paint();
    waterPainter.color = Color(0xFFEBF4FA); // TODO replace with water color
    waterPainter.style = PaintingStyle.fill;

    Path cupLiningPath = Path();

    cupLiningPath.moveTo(size.width * 0.2, size.height * 0.275);
    cupLiningPath.quadraticBezierTo(size.width * 0.5, size.height * 0.34,
        size.width * 0.8, size.height * 0.275);
    cupLiningPath.lineTo(size.width * 0.8, size.height * 0.7);
    cupLiningPath.lineTo(size.width * 0.2, size.height * 0.7);
    cupLiningPath.lineTo(size.width * 0.2, size.height * 0.275);
    cupLiningPath.quadraticBezierTo(size.width * 0.5, size.height * 0.24,
        size.width * 0.8, size.height * 0.275);

    Path waterPath = Path();

    waterPath.moveTo(size.width * 0.21, size.height * constant * 0.31);
    waterPath.moveTo(size.width * 0.79, size.height * constant * 0.31);
    waterPath.lineTo(size.width * 0.79, size.height * 0.695);
    waterPath.lineTo(size.width * 0.21, size.height * 0.695);
    waterPath.lineTo(size.width * 0.21, size.height * constant * 0.31);

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
