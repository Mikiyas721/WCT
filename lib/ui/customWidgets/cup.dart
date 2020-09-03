import 'package:flutter/material.dart';

class Cup extends CustomPainter {
  double x1;
  double x2;
  double y;

  double consumedAmount;
  double recommendedAmount;

  Cup({this.consumedAmount, this.recommendedAmount});

  @override
  void paint(Canvas canvas, Size size) {
    initWaterPainter(size);
    Paint cupLiningPainter = Paint();
    cupLiningPainter.color = Colors.brown;
    cupLiningPainter.style = PaintingStyle.stroke;

    Paint waterPainter = Paint();
    waterPainter.color = Colors.lightBlueAccent; // TODO replace with water color
    waterPainter.style = PaintingStyle.fill;

    Path cupLiningPath = Path();

    cupLiningPath.moveTo(size.width * 0.15, size.height * 0.3);
    cupLiningPath.lineTo(size.width * 0.9, size.height * 0.3);
    cupLiningPath.lineTo(size.width * 0.75, size.height * 0.7);
    cupLiningPath.lineTo(size.width * 0.3, size.height * 0.7);
    cupLiningPath.lineTo(size.width * 0.15, size.height * 0.3);

    Path waterPath = Path();

    waterPath.moveTo(x1, y);

    waterPath.lineTo(x2, y);

    waterPath.lineTo(size.width * 0.75, size.height * 0.7);
    waterPath.lineTo(size.width * 0.3, size.height * 0.7);

    waterPath.lineTo(x1, y);

    canvas.drawPath(cupLiningPath, cupLiningPainter);
    canvas.drawPath(waterPath, waterPainter);
  }

  initWaterPainter(Size size) {
    x1 = 0.154;
    x2 = 0.896;
    y = 0.31;

    if (consumedAmount != null && recommendedAmount != null) {
      double changeY = (0.39 * consumedAmount) / recommendedAmount;
      y += changeY;
      x1 = (y + 0.1) / 2.67;
      x2 = (y - 2.7) / (-2.67);
    }
    x1 *= size.width;
    x2 *= size.width;
    y *= size.height;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
