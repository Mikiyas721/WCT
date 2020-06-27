import 'package:flutter/material.dart';
import 'package:wct/ui/pages/conditionsPage.dart';
import 'package:wct/ui/pages/homePage.dart';
import 'package:wct/ui/pages/notificationPage.dart';
import 'package:wct/ui/pages/settingsPage.dart';
import 'package:wct/ui/pages/themePage.dart';
import 'package:wct/ui/pages/timePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = {
    '/': (BuildContext context) => HomePage(),
    '/settingsPage': (BuildContext context) => SettingsPage(),
    '/notificationPage': (BuildContext context) => NotificationPage(),
    '/conditionsPage': (BuildContext context) => ConditionsPage(),
    '/themePage': (BuildContext context) => ThemePage(),
    '/timePage': (BuildContext context) => TimePage(),
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
