import 'package:flutter/material.dart';
import 'package:wct/ui/pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = {
    '/': (BuildContext context)=>HomePage()
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water and Calorie Tracker',
      routes: routes,
      initialRoute: '/',
    );
  }
}
