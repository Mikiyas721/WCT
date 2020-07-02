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
    return rawMealFluid != null ? rawMealFluid.split('(')[0] : null;
  }

  void onAgeChanged(String newValue) {
    _ageRepo.updateStream(StringModel(data: newValue));
    _ageRepo.setPreference<String>(PreferenceKeys.age, newValue);
    fetchRecommended();
  }

  void onWeightEntered(String newValue) {
    _weightRepo.updateStream(StringModel(data: newValue));
    _weightRepo.setPreference<String>(PreferenceKeys.weight, newValue);
    fetchRecommended();
  }

  void onOtherDrinksChanged(String newValue) {
    _otherDrinksRepo.updateStream(StringModel(data: newValue));
    _otherDrinksRepo.setPreference<String>(
        PreferenceKeys.otherDrinks, newValue);
  }

  void onMealFluidsChanged(String newValue) {
    _mealFluidRepo.updateStream(StringModel(data: newValue));
    _mealFluidRepo.setPreference<String>(PreferenceKeys.mealFluid, newValue);
  }

  String fetchRecommended() {
    //TODO Handle Exceptions
    int age = mapAgeRange(_ageRepo.getPreference<String>(PreferenceKeys.age));
    String weight = _weightRepo.getPreference<String>(PreferenceKeys.weight);
    String recommendedAmount = '0.0';
    if(weight!=null){
      int weightInt = int.parse(weight == null ? '0' : weight);
      recommendedAmount = ((weightInt * age) / 956.54).toString();
      _recommendedRepo.updateStream(StringModel(data: recommendedAmount));
    }
    return recommendedAmount;
  }

  int mapAgeRange(String ageRange) {
    if (ageRange == '< 30 Years')
      return 40;
    else if (ageRange == '30 - 55 Years')
      return 35;
    else
      return 30;
  }

  @override
  void dispose() {}
}
