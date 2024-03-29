import 'dart:async';
import 'package:Nutracker/dataSource/notification/timeDataSource.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../dataSource/conditions/consumedDataSource.dart';
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
import 'timeBloc.dart';
import 'notificationBloc.dart';

class ConditionsBloc extends Disposable {
  AgeRepo _ageRepo = GetIt.instance.get();
  WeightRepo _weightRepo = GetIt.instance.get();
  OtherDrinksRepo _otherDrinksRepo = GetIt.instance.get();
  MealFluidRepo _mealFluidRepo = GetIt.instance.get();
  RecommendedRepo _recommendedRepo = GetIt.instance.get();
  ConsumedRepo _consumedRepo = GetIt.instance.get();
  ExerciseTypeRepo _exerciseTypeRepo = GetIt.instance.get();
  ExerciseLengthRepo _exerciseLengthRepo = GetIt.instance.get();
  TimeRepo _timeRepo = GetIt.instance.get();

  Stream<String> get ageStream => _ageRepo.getStream<String>((value) => value);

  Stream<String> get weightStream => _weightRepo.getStream<String>((value) => value);

  Stream<String> get otherDrinksStream => _otherDrinksRepo.getStream<String>((value) => value);

  Stream<String> get mealFluidStream => _mealFluidRepo.getStream<String>((value) => value);

  Stream<double> get recommendedStream => _recommendedRepo.getStream<double>((value) => value);

  Stream<String> get exerciseTypeStream => _exerciseTypeRepo.getStream<String>((value) => value);

  Stream<String> get exerciseLengthStream => _exerciseLengthRepo.getStream<String>((value) => value);

  Stream<double> get consumedStream => _consumedRepo.getStream<double>((value) => value);

  NotificationBloc notificationBloc = NotificationBloc();
  TimeBloc timeBloc = TimeBloc();
  String getAge(String age) {
    return age == null ? _ageRepo.getPreference<String>(PreferenceKeys.age) : age;
  }

  String getWeight(String weight) {
    return weight == null ? _weightRepo.getPreference<String>(PreferenceKeys.weight) : weight;
  }

  String getOtherDrinks(String otherDrinks) {
    return otherDrinks == null
        ? _otherDrinksRepo.getPreference<String>(PreferenceKeys.otherDrinks)
        : otherDrinks;
  }

  String getMealFluid(String mealFluid) {
    return mealFluid == null ? _mealFluidRepo.getPreference<String>(PreferenceKeys.mealFluid) : mealFluid;
  }

  String getMealFluidTrailing(String mealFluid) {
    String rawMealFluid;
    mealFluid == null
        ? rawMealFluid = _mealFluidRepo.getPreference<String>(PreferenceKeys.mealFluid)
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
        ? _exerciseLengthRepo.getPreference<String>(PreferenceKeys.exerciseLength)
        : exerciseLength;
  }

  void onAgeChanged(String newValue) {
    _ageRepo.updateStream(StringModel(data: newValue));
    _ageRepo.setPreference<String>(PreferenceKeys.age, newValue);
    fetchRecommended();
  }

  void onWeightChanged(num newValue) {
    if (newValue.toString() != '') {
      _weightRepo.updateStream(StringModel(data: newValue.toString()));
      _weightRepo.setPreference<String>(PreferenceKeys.weight, newValue.toString());
      fetchRecommended();
    }
  }

  void onOtherDrinksChanged(String newValue) {
    _otherDrinksRepo.updateStream(StringModel(data: newValue));
    _otherDrinksRepo.setPreference<String>(PreferenceKeys.otherDrinks, newValue);
    fetchRecommended();
  }

  void onMealFluidsChanged(String newValue) {
    _mealFluidRepo.updateStream(StringModel(data: newValue));
    _mealFluidRepo.setPreference<String>(PreferenceKeys.mealFluid, newValue);
    fetchRecommended();
  }

  void onExerciseTypeChanged(String newValue) {
    _exerciseTypeRepo.updateStream(StringModel(data: newValue));
    _exerciseTypeRepo.setPreference<String>(PreferenceKeys.exerciseType, newValue);
    getExerciseTimeRecommended();
  }

  void onExerciseLengthChanged(num newValue) {
    if (newValue.toString() != '') {
      _exerciseLengthRepo.updateStream(StringModel(data: newValue.toString()));
      _exerciseLengthRepo.setPreference<String>(PreferenceKeys.exerciseLength, newValue.toString());
      getExerciseTimeRecommended();
    }
  }

  String fetchRecommended() {
    //TODO Handle Exceptions
    int age = mapAgeRange(_ageRepo.getPreference<String>(PreferenceKeys.age));
    String weight = _weightRepo.getPreference<String>(PreferenceKeys.weight);
    String otherDrinks = _otherDrinksRepo.getPreference<String>(PreferenceKeys.otherDrinks);
    String mealFluid = _mealFluidRepo.getPreference<String>(PreferenceKeys.mealFluid);
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
      else if (mealFluid == "Very Much (Mainly fruits and Vegetables)") basicAmount -= 0.4;
      basicAmount = roundDouble(basicAmount, 2);
      recommendedAmount = basicAmount.toString();
      _recommendedRepo.updateStream(DoubleModel(data: double.parse(recommendedAmount)));
    }
    return recommendedAmount;
  }

  String getExerciseTimeRecommended() {
    String type = _exerciseTypeRepo.getPreference<String>(PreferenceKeys.exerciseType);
    double length = double.parse(_exerciseLengthRepo.getPreference<String>(PreferenceKeys.exerciseLength));
    double typeConstant = mapTypeConstant(type);
    double currentAmount;
    length /= getTypeLength(type);
    currentAmount = length * typeConstant;
    currentAmount = ((currentAmount / 0.25).round()) * 0.25;
    _recommendedRepo.updateStream(DoubleModel(data: currentAmount));
    return currentAmount.toString();
  }

  // TODO Adjust the precision of the recommended Amount
  void onOneCup() {
    AudioCache audioPlayer = AudioCache();
    audioPlayer.play('Water.mp3');
    double takenSoFar = _consumedRepo.getPreference<double>(PreferenceKeys.consumedAmount);
    takenSoFar == null ? takenSoFar = 0 : takenSoFar = takenSoFar;
    _consumedRepo.setPreference<double>(PreferenceKeys.consumedAmount, takenSoFar += 0.25);
    _consumedRepo.updateStream(DoubleModel(data: takenSoFar += 0.25));
  }

  void onTwoCup() {
    double takenSoFar = _consumedRepo.getPreference<double>(PreferenceKeys.consumedAmount);
    takenSoFar == null ? takenSoFar = 0 : takenSoFar = takenSoFar;
    _consumedRepo.setPreference<double>(PreferenceKeys.consumedAmount, takenSoFar += 0.5);
    _consumedRepo.updateStream(DoubleModel(data: takenSoFar += 0.5));
  }

  double progress(double snapShot) {
    double soFar = _consumedRepo.getPreference<double>(PreferenceKeys.consumedAmount);
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

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    double number = ((value * mod).round().toDouble() / mod);
    return ((number / 0.25).ceil()) * 0.25; //Multiple of a cup
  }

  bool isNowExercising() {
    return false;
  }

  double consumedAmount(double data) {
    return data == null ? _consumedRepo.getPreference<double>(PreferenceKeys.consumedAmount) : data;
  }

  double remainingAmount(double data) {
    return data == null
        ? double.parse(fetchRecommended()) -
            _consumedRepo.getPreference<double>(PreferenceKeys.consumedAmount)
        : double.parse(fetchRecommended()) - data;
  }

  void onStopAlarm() {
    FlutterRingtonePlayer.stop();
    //TODO stop vibration here
  }

  String getUnitAmount() {
    return roundDouble(
            ((double.parse(fetchRecommended()) *
                    timeBloc.getCountDownTime(null)) / //TODO check for an alternative
                (1440 - notificationBloc.getSleepingTimeRange())),
            2)
        .toString();
  }

  int getUnitAmountInCups() {
    return (double.parse(getUnitAmount()) ~/ 0.25) == 0.0 ? 1 : (double.parse(getUnitAmount()) ~/ 0.25);
  }

  void onDrinkConfirmed(int cupCount) {
    double takenSoFar = _consumedRepo.getPreference<double>(PreferenceKeys.consumedAmount);
    double dailyRecommended = double.parse(fetchRecommended());

    if (takenSoFar < dailyRecommended) {
      _consumedRepo.setPreference<double>(PreferenceKeys.consumedAmount, takenSoFar += (0.25 * cupCount));
      _consumedRepo.updateStream(DoubleModel(data: takenSoFar += (0.25 * cupCount)));
    }

    String alarm = _consumedRepo.getPreference<String>(PreferenceKeys.alarm);

    if (alarm == 'Sound') {
      onStopAlarm();
      AudioCache audioPlayer = AudioCache();
      audioPlayer.play('Water.mp3');
    }

    if (!hasTime()) {
      // TODO Record on Database the Consumed and remaining Amount
      _consumedRepo.updateStream(DoubleModel(data: 0.0));
    } else {
      if (remainingAmount(null) <= 0.0) {
        //TODO Display a message showing that they have completed the Day
        _consumedRepo.setPreference<double>(PreferenceKeys.consumedAmount, 0.0);
        _consumedRepo.updateStream(DoubleModel(data: 0.0));
      }
      _timeRepo.updateStream(StringModel(data: _consumedRepo.getPreference<String>(PreferenceKeys.time)));
    }
  }

  bool hasTime() {
    return true;
  }

  @override
  void dispose() {}
}
