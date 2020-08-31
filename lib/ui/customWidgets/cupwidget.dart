import '../../ui/customWidgets/cup.dart';
import 'package:flutter/material.dart';

class CupWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupWidgetState();
  }
}

class _CupWidgetState extends State<CupWidget> with TickerProviderStateMixin {
  Animation<double> waterAnimation;
  AnimationController waterController;

  @override
  void initState() {
    super.initState();
    waterController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    waterAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.bounceOut,
      parent: waterController,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: waterAnimation,
      builder: (BuildContext context, Widget child) {
        return Center(
          child: CustomPaint(painter: Cup()),
        );
      },
    );
  }
}
