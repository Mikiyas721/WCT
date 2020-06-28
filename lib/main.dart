import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wct/resources/myThemeData.dart';
import './injector.dart';
import './ui/pages/conditionsPage.dart';
import './ui/pages/homePage.dart';
import './ui/pages/notificationPage.dart';
import './ui/pages/settingsPage.dart';
import './ui/pages/themePage.dart';
import './ui/pages/timePage.dart';

import 'dataSource/themeDataSource.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await inject();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeRepo = GetIt.instance.get<ThemeRepo>();
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
    return StreamBuilder(
      stream: themeRepo.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
            title: 'Water and Calorie Tracker',
            routes: routes,
            initialRoute: '/',
            theme: snapshot.data == null
                ? MyThemeData.defaultLight
                : snapshot.data);
      },
    );
  }
}
