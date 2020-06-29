import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import './models/theme.dart';
import './resources/preferenceKeys.dart';
import './resources/myThemeData.dart';
import './injector.dart';
import 'ui/pages/settings/water/conditionsPage.dart';
import './ui/pages/homePage.dart';
import 'ui/pages/settings/water/notificationPage.dart';
import 'ui/pages/settings/settingsPage.dart';
import 'ui/pages/settings/general/themePage.dart';
import 'dataSource/themeDataSource.dart';
import 'models/theme.dart';
import 'resources/preferenceKeys.dart';

void main() async {
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
  };

  @override
  Widget build(BuildContext context) {
    String savedTheme =
        themeRepo.getPreference<String>(PreferenceKeys.selectedTheme);
    themeRepo.updateStream(ThemeModel(name: savedTheme));
    return StreamBuilder(
      stream: themeRepo.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
            title: 'Nutrition Tracker',
            routes: routes,
            initialRoute: '/',
            theme: snapshot.data == null
                ? MyThemeData.defaultLight
                : snapshot.data);
      },
    );
  }
}
