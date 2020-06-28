import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wct/dataSource/themeDataSource.dart';
import 'package:wct/models/theme.dart';

void inject() async {
  final preference = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(preference);

  GetIt.instance.registerLazySingleton<ThemeRepo>(
      () => ThemeRepo(BehaviorSubject<ThemeModel>()));
}
