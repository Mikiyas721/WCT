import './models/boolean.dart';
import './models/string.dart';
import './dataSource/themeDataSource.dart';
import './models/theme.dart';
import './dataSource/conditions/ageDataSource.dart';
import './dataSource/conditions/mealFluidDataSource.dart';
import './dataSource/conditions/otherDrinkDataSource.dart';
import './dataSource/conditions/weightDataSource.dart';
import './dataSource/conditions/recommendedDataSource.dart';
import './dataSource/notification/alarmDataSource.dart';
import './dataSource/notification/nowExercisingDataSource.dart';
import './dataSource/notification/disableNotificationDataSource.dart';
import './dataSource/notification/notificationDataSource.dart';
import './dataSource/notification/popupDataSource.dart';
import 'dataSource/notification/24DataSource.dart';
import 'dataSource/notification/timeDataSource.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dataSource/conditions/exerciseLengthDataSource.dart';
import 'dataSource/conditions/exerciseTypeDataSource.dart';
import 'dataSource/conditions/consumedDataSource.dart';
import 'dataSource/notification/sleepTimeRepo.dart';
import 'models/double.dart';

void inject() async {
  final preference = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(preference);

  GetIt.instance.registerLazySingleton<ThemeRepo>(
      () => ThemeRepo(BehaviorSubject<ThemeModel>()));
  GetIt.instance.registerLazySingleton<AgeRepo>(
      () => AgeRepo(BehaviorSubject<StringModel>()));
  GetIt.instance.registerLazySingleton<ExerciseLengthRepo>(
      () => ExerciseLengthRepo(BehaviorSubject<StringModel>()));
  GetIt.instance.registerLazySingleton<ExerciseTypeRepo>(
      () => ExerciseTypeRepo(BehaviorSubject<StringModel>()));
  GetIt.instance.registerLazySingleton<MealFluidRepo>(
      () => MealFluidRepo(BehaviorSubject<StringModel>()));
  GetIt.instance.registerLazySingleton<OtherDrinksRepo>(
      () => OtherDrinksRepo(BehaviorSubject<StringModel>()));
  GetIt.instance.registerLazySingleton<WeightRepo>(
      () => WeightRepo(BehaviorSubject<StringModel>()));
  GetIt.instance.registerLazySingleton<RecommendedRepo>(
      () => RecommendedRepo(BehaviorSubject<DoubleModel>()));
  GetIt.instance.registerLazySingleton<ConsumedRepo>(
      () => ConsumedRepo(BehaviorSubject<DoubleModel>()));

  GetIt.instance.registerLazySingleton<DisableNotificationRepo>(
      () => DisableNotificationRepo(BehaviorSubject<BooleanModel>()));
  GetIt.instance.registerLazySingleton<NowExercisingRepo>(
      () => NowExercisingRepo(BehaviorSubject<BooleanModel>()));
  GetIt.instance.registerLazySingleton<NotificationRepo>(
      () => NotificationRepo(BehaviorSubject<BooleanModel>()));
  GetIt.instance.registerLazySingleton<PopUpRepo>(
      () => PopUpRepo(BehaviorSubject<BooleanModel>()));
  GetIt.instance.registerLazySingleton<AlarmRepo>(
      () => AlarmRepo(BehaviorSubject<StringModel>()));
  GetIt.instance.registerLazySingleton<SleepTimeRepo>(
      () => SleepTimeRepo(BehaviorSubject<StringModel>()));
  GetIt.instance.registerLazySingleton<Repo24>(
      () => Repo24(BehaviorSubject<BooleanModel>()));
  GetIt.instance.registerLazySingleton<TimeRepo>(
      () => TimeRepo(BehaviorSubject<StringModel>()));
}
