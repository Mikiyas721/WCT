import 'dart:async';
import 'package:flutter/material.dart';

class MyCountDownTimer extends StatefulWidget {
  final MyCountDownTimerState myCountDownTimerState;

  MyCountDownTimer(String title, int minutes)
      : myCountDownTimerState = MyCountDownTimerState(title, minutes);

  @override
  State<StatefulWidget> createState() {
    return myCountDownTimerState;
  }
}

class MyCountDownTimerState extends State<MyCountDownTimer> {
  String title;
  int second = 0;
  int minutes;
  int hours;

  MyCountDownTimerState(this.title, this.minutes) {
    hours = minutes ~/ 60;
    minutes = minutes - (60 * hours);
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (second == 0) {
          second = 60;
          minutes -= 1;
        } else
          second -= 1;
      });
    });
    return Text('$title ${hours}H:${minutes}M:${second}S ');
  }
}
