import '../dataSource/conditions/soFarDataSource.dart';
import '../models/double.dart';
import '../dataSource/conditions/exerciseLengthDataSource.dart';
import '../dataSource/conditions/exerciseTypeDataSource.dart';
import '../dataSource/conditions/recommendedDataSource.dart';
import '../models/string.dart';
import '../resources/preferenceKeys.dart';
import '../core/utils/disposable.dart';
import '../dataSource/conditions/ageDataSource.dart';
import '../dataSource/conditions/mealFluidDataSource.dart';
import '../dataSource/conditions/otherDrinkDataSource.dart';
import '../dataSource/conditions/weightDataSource.dart';
import 'package:get_it/get_it.dart';
import 'dart:math';

class ConditionsBloc extends Disposable {
  AgeRepo _ageRepo = GetIt.instance.get();
  WeightRepo _weightRepo = GetIt.instance.get();
  OtherDrinksRepo _otherDrinksRepo = GetIt.instance.get();
  MealFluidRepo _mealFluidRepo = GetIt.instance.get();
  RecommendedRepo _recommendedRepo = GetIt.instance.get();
  ExerciseTypeRepo _exerciseTypeRepo = GetIt.instance.get();
  ExerciseLengthRepo _exerciseLengthRepo = GetIt.instance.get();
  SoFarRepo _soFarRepo = GetIt.instance.get();

  Stream<String> get ageStream => _ageRepo.getStream<String>((value) => value);

  Stream<String> get weightStream =>
      _weightRepo.getStream<String>((value) => value);

  Stream<String> get otherDrinksStream =>
      _otherDrinksRepo.getStream<String>((value) => value);

  Stream<String> get mealFluidStream =>
      _mealFluidRepo.getStream<String>((value) => value);

  Stream<double> get recommendedStream =>
      _recommendedRepo.getStream<double>((value) => value);

  Stream<String> get exerciseTypeStream =>
      _exerciseTypeRepo.getStream<String>((value) => value);

  Stream<String> get exerciseLengthStream =>
      _exerciseLengthRepo.getStream<String>((value) => value);

  Stream<double> get soFarStream =>
      _soFarRepo.getStream<double>((value) => value);

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

  String getExerciseType(String exerciseType) {
    return exerciseType == null
        ? _exerciseTypeRepo.getPreference<String>(PreferenceKeys.exerciseType)
        : exerciseType;
  }

  String getExerciseLength(String exerciseLength) {
    return exerciseLength == null
        ? _exerciseLengthRepo
            .getPreference<String>(PreferenceKeys.exerciseLength)
        : exerciseLength;
  }

  void onAgeChanged(String newValue) {
    _ageRepo.updateStream(StringModel(data: newValue));
    _ageRepo.setPreference<String>(PreferenceKeys.age, newValue);
    fetchRecommended();
  }

  void onWeightEntered(String newValue) {
    if (newValue != '') {
      _weightRepo.updateStream(StringModel(data: newValue));
      _weightRepo.setPreference<String>(PreferenceKeys.weight, newValue);
      fetchRecommended();
    }
  }

  void onOtherDrinksChanged(String newValue) {
    _otherDrinksRepo.updateStream(StringModel(data: newValue));
    _otherDrinksRepo.setPreference<String>(
        PreferenceKeys.otherDrinks, newValue);
    fetchRecommended();
  }

  void onMealFluidsChanged(String newValue) {
    _mealFluidRepo.updateStream(StringModel(data: newValue));
    _mealFluidRepo.setPreference<String>(PreferenceKeys.mealFluid, newValue);
    fetchRecommended();
  }

  void onExerciseTypeChanged(String newValue) {
    _exerciseTypeRepo.updateStream(StringModel(data: newValue));
    _exerciseTypeRepo.setPreference<String>(
        PreferenceKeys.exerciseType, newValue);
    getExerciseTimeRecommended();
  }

  void onExerciseLengthChanged(String newValue) {
    if (newValue != '') {
      _exerciseLengthRepo.updateStream(StringModel(data: newValue));
      _exerciseLengthRepo.setPreference<String>(
          PreferenceKeys.exerciseLength, newValue);
      getExerciseTimeRecommended();
    }
  }

  String fetchRecommended() {
    //TODO Handle Exceptions
    int age = mapAgeRange(_ageRepo.getPreference<String>(PreferenceKeys.age));
    String weight = _weightRepo.getPreference<String>(PreferenceKeys.weight);
    String otherDrinks =
        _otherDrinksRepo.getPreference<String>(PreferenceKeys.otherDrinks);
    String mealFluid =
        _mealFluidRepo.getPreference<String>(PreferenceKeys.mealFluid);
    String recommendedAmount = '0.0';
    if (weight != null) {
      int weightInt = int.parse(weight == null ? '0' : weight);
      double basicAmount = (weightInt * age) / 956.54;

      if (otherDrinks == "Medium")
        basicAmount -= 0.2;
      else if (otherDrinks == "High") basicAmount -= 0.5;

      if (mealFluid == "Little")
        basicAmount -= 0.1;
      else if (mealFluid == "Average")
        basicAmount -= 0.2;
      else if (mealFluid == "Very Much (Mainly fruits and Vegetables)")
        basicAmount -= 0.4;
      recommendedAmount = basicAmount.toString();
      _recommendedRepo
          .updateStream(DoubleModel(data: double.parse(recommendedAmount)));
    }
    return recommendedAmount;
  }

  String getExerciseTimeRecommended() {
    String type =
        _exerciseTypeRepo.getPreference<String>(PreferenceKeys.exerciseType);
    double length = double.parse(_exerciseLengthRepo
        .getPreference<String>(PreferenceKeys.exerciseLength));
    double typeConstant = mapTypeConstant(type);
    length /= getTypeLength(type);
    String current = (length * typeConstant).toString();
    _recommendedRepo.updateStream(DoubleModel(data: double.parse(current)));
    return current;
  }

  String getRecommendedString() {
    bool isNowExercising =
        _exerciseTypeRepo.getPreference<bool>(PreferenceKeys.nowExercising);
    String recommended;
    isNowExercising == true
        ? recommended = getExerciseTimeRecommended()
        : recommended = fetchRecommended();
    recommended.length > 5
        ? recommended = recommended.substring(0, 5)
        : recommended = recommended; //TODO Replace with Math round
    return 'Current recommended amount $recommended Ls';
  }

  void onOneCup() {
    double takenSoFar = _soFarRepo.getPreference<double>(PreferenceKeys.soFar);
    takenSoFar == null ? takenSoFar = 0 : takenSoFar = takenSoFar;
    _soFarRepo.setPreference<double>(PreferenceKeys.soFar, takenSoFar += 0.25);
    _soFarRepo.updateStream(DoubleModel(data: takenSoFar += 0.25));
  }

  void onTwoCup() {
    double takenSoFar = _soFarRepo.getPreference<double>(PreferenceKeys.soFar);
    takenSoFar == null ? takenSoFar = 0 : takenSoFar = takenSoFar;
    _soFarRepo.setPreference<double>(PreferenceKeys.soFar, takenSoFar += 0.5);
    _soFarRepo.updateStream(DoubleModel(data: takenSoFar += 0.5));
  }

  double progress(double snapShot) {
    double soFar = _soFarRepo.getPreference<double>(PreferenceKeys.soFar);
    soFar = snapShot == null ? soFar == null ? 0 : soFar : snapShot;
    return (soFar / double.parse(fetchRecommended()));
  }

  int mapAgeRange(String ageRange) {
    if (ageRange == '< 30 Years')
      return 40;
    else if (ageRange == '30 - 55 Years')
      return 35;
    else
      return 30;
  }

  double mapTypeConstant(String type) {
    if (type == 'A little')
      return 0.8;
    else if (type == 'Average')
      return 1;
    else
      return 1.2;
  }

  double getTypeLength(String type) {
    if (type == 'A little')
      return 40;
    else if (type == 'Average')
      return 50;
    else
      return 60;
  }

  @override
  void dispose() {}
}
