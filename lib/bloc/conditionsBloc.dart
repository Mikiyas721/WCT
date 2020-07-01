import '../dataSource/conditions/recommendedDataSource.dart';
import '../models/conditions.dart';
import '../resources/preferenceKeys.dart';
import '../core/utils/disposable.dart';
import '../dataSource/conditions/ageDataSource.dart';
import '../dataSource/conditions/mealFluidDataSource.dart';
import '../dataSource/conditions/otherDrinkDataSource.dart';
import '../dataSource/conditions/weightDataSource.dart';
import 'package:get_it/get_it.dart';

class ConditionsBloc extends Disposable {
  AgeRepo _ageRepo = GetIt.instance.get();
  WeightRepo _weightRepo = GetIt.instance.get();
  OtherDrinksRepo _otherDrinksRepo = GetIt.instance.get();
  MealFluidRepo _mealFluidRepo = GetIt.instance.get();
  RecommendedRepo _recommendedRepo = GetIt.instance.get();

  String _tempAge;

  Stream<String> get ageStream => _ageRepo.getStream<String>((value) => value);

  Stream<String> get weightStream =>
      _weightRepo.getStream<String>((value) => value);

  Stream<String> get otherDrinksStream =>
      _otherDrinksRepo.getStream<String>((value) => value);

  Stream<String> get mealFluidStream =>
      _mealFluidRepo.getStream<String>((value) => value);

  Stream<String> get recommendedStream =>
      _recommendedRepo.getStream<String>((value) => value);

  String getAge(String age) {
    return age == null
        ? _ageRepo.getPreference<String>(PreferenceKeys.age)
        : age;
  }

  String getWeight(String weight) {
    return weight == null
        ? _weightRepo.getPreference<String>(PreferenceKeys.weight)
        : weight;
  }

  String getOtherDrinks(String otherDrinks) {
    return otherDrinks == null
        ? _otherDrinksRepo.getPreference<String>(PreferenceKeys.otherDrinks)
        : otherDrinks;
  }

  String getMealFluid(String mealFluid) {
    return mealFluid == null
        ? _mealFluidRepo.getPreference<String>(PreferenceKeys.mealFluid)
        : mealFluid;
  }

  String getMealFluidTrailing(String mealFluid) {
    String rawMealFluid;
    mealFluid == null
        ? rawMealFluid =
            _mealFluidRepo.getPreference<String>(PreferenceKeys.mealFluid)
        : rawMealFluid = mealFluid;
    return mealFluid != null ? rawMealFluid.split('(')[0] : null;
  }

  void setTempoAge(String newValue) {
    _tempAge = newValue;
  }

  void onAgeSubmitted() {
    _ageRepo.updateStream(StringModel(data: _tempAge));
    _ageRepo.setPreference<String>(PreferenceKeys.age, _tempAge);
  }

  void onWeightSubmitted() {
    _weightRepo.updateStream(StringModel(data: _tempAge));
    _weightRepo.setPreference<String>(PreferenceKeys.weight, _tempAge);
  }

  void onOtherDrinksSubmitted() {
    _otherDrinksRepo.updateStream(StringModel(data: _tempAge));
    _otherDrinksRepo.setPreference<String>(
        PreferenceKeys.otherDrinks, _tempAge);
  }

  void onMealFluidsSubmitted() {
    _mealFluidRepo.updateStream(StringModel(data: _tempAge));
    _mealFluidRepo.setPreference<String>(PreferenceKeys.mealFluid, _tempAge);
  }

  void fetchRecommended() {}

  @override
  void dispose() {
  }
}
