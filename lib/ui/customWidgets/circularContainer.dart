import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final Color backGroundColor;
  final double width;
  final double height;

  CircularContainer({this.backGroundColor, this.width = 30, this.height = 30});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backGroundColor,
      ),
    );
  }
}
