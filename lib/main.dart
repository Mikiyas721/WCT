import 'package:flutter/material.dart';
import 'package:wct/ui/pages/homePage.dart';
import 'package:wct/ui/pages/settingsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = {
    '/': (BuildContext context) => HomePage(),
    '/settingsPage': (BuildContext context) => SettingsPage()
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
