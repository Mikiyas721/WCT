import 'package:flutter/material.dart';

class Cup extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.lightBlue;
    paint.style = PaintingStyle.stroke;

    var path = Path();

    path.moveTo(size.width*0.35, size.height * 0.275);
    path.quadraticBezierTo(size.width*0.5, size.height * 0.34, size.width*0.65, size.height * 0.275);
    path.lineTo(size.width*0.65, size.height * 0.7);
    path.lineTo(size.width*0.35, size.height * 0.7);
    path.lineTo(size.width*0.35, size.height * 0.275);
    path.quadraticBezierTo(size.width*0.5, size.height * 0.24, size.width*0.65, size.height * 0.275);


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}