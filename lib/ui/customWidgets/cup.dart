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
    cupLiningPainter.color = Colors.lightBlue;
    cupLiningPainter.style = PaintingStyle.stroke;

    Paint waterPainter = Paint();
    waterPainter.color = Color(0x222255FF); // TODO replace with water color
    waterPainter.style = PaintingStyle.fill;

    Path cupLiningPath = Path();

    cupLiningPath.moveTo(size.width * 0.35, size.height * 0.275);
    cupLiningPath.quadraticBezierTo(size.width * 0.5, size.height * 0.34,
        size.width * 0.65, size.height * 0.275);
    cupLiningPath.lineTo(size.width * 0.65, size.height * 0.7);
    cupLiningPath.lineTo(size.width * 0.35, size.height * 0.7);
    cupLiningPath.lineTo(size.width * 0.35, size.height * 0.275);
    cupLiningPath.quadraticBezierTo(size.width * 0.5, size.height * 0.24,
        size.width * 0.65, size.height * 0.275);

    Path waterPath = Path();

    waterPath.moveTo(size.width * 0.355, size.height * constant * 0.31);
    waterPath.moveTo(size.width * 0.645, size.height * constant * 0.31);
    waterPath.lineTo(size.width * 0.645, size.height * 0.695);
    waterPath.lineTo(size.width * 0.355, size.height * 0.695);
    waterPath.lineTo(size.width * 0.355, size.height * constant * 0.31);

    canvas.drawPath(cupLiningPath, cupLiningPainter);
    canvas.drawPath(waterPath, waterPainter);
  }

  decrease(double intake) {
    if (constant <= 2.2) {
      constant += intake;
      print(constant);
    }
  }

  refill() {
    constant = 1;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
