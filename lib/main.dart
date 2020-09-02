import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

final themeRepo = GetIt.instance.get<ThemeRepo>();
void main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await inject();
  bool isDefaultSet = themeRepo.getPreference<bool>(PreferenceKeys.isDefaultSet);
  if (isDefaultSet == null || isDefaultSet == false) setUpDefaults();
  runApp(MyApp());
}

setUpDefaults() {
  themeRepo.setPreference<String>(PreferenceKeys.selectedTheme, 'DefaultLight');
  themeRepo.setPreference<String>(PreferenceKeys.age, '< 30 Years');
  themeRepo.setPreference<String>(PreferenceKeys.weight, '50');
  themeRepo.setPreference<String>(PreferenceKeys.otherDrinks, 'Medium');
  themeRepo.setPreference<String>(PreferenceKeys.mealFluid, 'Average');
  themeRepo.setPreference<String>(PreferenceKeys.exerciseType, 'Average');
  themeRepo.setPreference<String>(PreferenceKeys.exerciseLength, '45');
  themeRepo.setPreference<double>(PreferenceKeys.consumedAmount, 0.0);
  themeRepo.setPreference<bool>(PreferenceKeys.isNotificationDisabled, false);
  themeRepo.setPreference<bool>(PreferenceKeys.nowExercising, true);
  themeRepo.setPreference<bool>(PreferenceKeys.notify, true);
  themeRepo.setPreference<bool>(PreferenceKeys.popupNotification, false);
  themeRepo.setPreference<String>(PreferenceKeys.alarm, 'Sound');
  themeRepo.setPreference<String>(PreferenceKeys.time, '40 Minutes');
  themeRepo.setPreference<String>(PreferenceKeys.sleepingTime, true);
  themeRepo.setPreference<bool>(PreferenceKeys.is24, false);
  themeRepo.setPreference<bool>(PreferenceKeys.isDefaultSet, true);
  //TODO refactor the DataTypes of some of the attributes
}

class MyApp extends StatelessWidget {
  final routes = {
    '/': (BuildContext context) => HomePage(),
    '/settingsPage': (BuildContext context) => SettingsPage(),
    '/notificationPage': (BuildContext context) => NotificationPage(),
    '/conditionsPage': (BuildContext context) => ConditionsPage(),
    '/themePage': (BuildContext context) => ThemePage(),
  };

  @override
  Widget build(BuildContext context) {
    String savedTheme = themeRepo.getPreference<String>(PreferenceKeys.selectedTheme);
    themeRepo.updateStream(ThemeModel(name: savedTheme));
    return StreamBuilder(
      stream: themeRepo.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
            title: 'Nutrition Tracker', routes: routes, initialRoute: '/', theme: snapshot.data == null ? MyThemeData.defaultLight : snapshot.data);
      },
    );
  }
}
