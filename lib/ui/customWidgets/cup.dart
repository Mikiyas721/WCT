import 'package:flutter/material.dart';

class Cup extends CustomPainter {
  double x01;
  double x02;
  double x03;
  double x04;
  double x5;
  double x11;
  double x12;
  double x13;
  double x14;

  double y01;
  double y02;
  double y03;
  double y04;
  double y5;
  double y11;
  double y12;
  double y13;
  double y14;

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

    waterPath.moveTo(x01, y01);
    waterPath.quadraticBezierTo(x02, y02, x03, y03);
    waterPath.quadraticBezierTo(x04, y04, x5, y5);
    waterPath.quadraticBezierTo(x11, y11, x12, y12);
    waterPath.quadraticBezierTo(x13, y13, x14, y14);

    waterPath.lineTo(size.width * 0.75, size.height * 0.7);
    waterPath.lineTo(size.width * 0.3, size.height * 0.7);
    waterPath.lineTo(x01, y01);

    canvas.drawPath(cupLiningPath, cupLiningPainter);
    canvas.drawPath(waterPath, waterPainter);
  }

  initWaterPainter(Size size) {
    x01 = size.width * 0.154;
    x02 = size.width * 0.099;
    x03 = size.width * 0.3375;
    x04 = size.width * 0.44;

    x5 = size.width * 0.525;

    x11 = size.width * 0.61;
    x12 = size.width * 0.7125;
    x13 = size.width * 0.815;
    x14 = size.width * 0.895;
// Y
    y01 = size.height * 0.31;
    y02 = size.height * 0.315;
    y03 = size.height * 0.3;
    y04 = size.height * 0.302;

    y5 = size.height * 0.31;

    y11 = size.height * 0.319;
    y12 = size.height * 0.32;
    y13 = size.height * 0.319;
    y14 = size.height * 0.31;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
