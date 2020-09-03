import '../dataSource/notification/24DataSource.dart';
import 'package:flutter/material.dart';
import '../models/string.dart';
import '../dataSource/notification/alarmDataSource.dart';
import '../dataSource/notification/nowExercisingDataSource.dart';
import '../dataSource/notification/notificationDataSource.dart';
import '../dataSource/notification/popupDataSource.dart';
import '../dataSource/notification/sleepTimeRepo.dart';
import '../models/boolean.dart';
import '../resources/preferenceKeys.dart';
import 'package:get_it/get_it.dart';
import '../dataSource/notification/disableNotificationDataSource.dart';
import '../core/utils/disposable.dart';

class NotificationBloc extends Disposable {
  DisableNotificationRepo _disableNotificationRepo = GetIt.instance.get();
  NowExercisingRepo _nowExercisingRepo = GetIt.instance.get();
  NotificationRepo _notificationRepo = GetIt.instance.get();
  PopUpRepo _popUpRepo = GetIt.instance.get();
  AlarmRepo _alarmRepo = GetIt.instance.get();
  SleepTimeRepo _sleepTimeRepo = GetIt.instance.get();
  Repo24 _repo24 = GetIt.instance.get();

  Stream<bool> get disableNotificationStream =>
      _disableNotificationRepo.getStream<bool>((newValue) => newValue);

  Stream<bool> get nowExercisingStream => _nowExercisingRepo.getStream<bool>((newValue) => newValue);

  Stream<bool> get notificationStream => _notificationRepo.getStream<bool>((newValue) => newValue);

  Stream<bool> get popupStream => _popUpRepo.getStream<bool>((newValue) => newValue);

  Stream<String> get alarmStream => _alarmRepo.getStream<String>((newValue) => newValue);

  Stream<String> get sleepTimeStream => _sleepTimeRepo.getStream<String>((newValue) => newValue);

  Stream<bool> get repo24Stream => _repo24.getStream<bool>((newValue) => newValue);

  void onDisableTap(bool newValue) {
    _disableNotificationRepo.updateStream(BooleanModel(newValue));
    _disableNotificationRepo.setPreference<bool>(PreferenceKeys.isNotificationDisabled, newValue);
  }

  void onNowExercisingTap(bool newValue) {
    _nowExercisingRepo.updateStream(BooleanModel(newValue));
    _nowExercisingRepo.setPreference<bool>(PreferenceKeys.nowExercising, newValue);
  }

  void onNotificationTap(bool newValue) {
    _notificationRepo.updateStream(BooleanModel(newValue));
    _notificationRepo.setPreference<bool>(PreferenceKeys.notify, newValue);
  }

  void onPopupTap(bool newValue) {
    _popUpRepo.updateStream(BooleanModel(newValue));
    _popUpRepo.setPreference<bool>(PreferenceKeys.popupNotification, newValue);
  }

  bool disableValue(bool snapshot) {
    bool x = _disableNotificationRepo.getPreference<bool>(PreferenceKeys.isNotificationDisabled);
    return snapshot == null ? x == null ? false : x : snapshot;
  }

  bool nowExercisingValue(bool snapshot) {
    bool x = _nowExercisingRepo.getPreference<bool>(PreferenceKeys.nowExercising);
    return snapshot == null ? x == null ? false : x : snapshot;
  }

  bool notificationValue(bool snapshot) {
    bool x = _notificationRepo.getPreference<bool>(PreferenceKeys.notify);
    return snapshot == null ? x == null ? false : x : snapshot;
  }

  bool popupValue(bool snapshot) {
    bool x = _popUpRepo.getPreference<bool>(PreferenceKeys.popupNotification);
    return snapshot == null ? x == null ? false : x : snapshot;
  }

  String alarmGroupValue(String snapshot) {
    return snapshot == null ? _alarmRepo.getPreference<String>(PreferenceKeys.alarm) : snapshot;
  }

  void onAlarmChanged(String newValue) {
    _alarmRepo.updateStream(StringModel(data: newValue));
    _alarmRepo.setPreference<String>(PreferenceKeys.alarm, newValue);
  }

  void onAlarmSwitched() {
    String alarmState = _alarmRepo.getPreference<String>(PreferenceKeys.alarm);
    String newAlarm;
    if (alarmState == "Silent")
      newAlarm = "Vibrate";
    else if (alarmState == "Vibrate")
      newAlarm = "Sound";
    else if (alarmState == "Sound") newAlarm = "Silent";
    _alarmRepo.updateStream(StringModel(data: newAlarm));
    _alarmRepo.setPreference<String>(PreferenceKeys.alarm, newAlarm);
  }

  void on24Changed(bool newValue) {
    _repo24.updateStream(BooleanModel(newValue));
    _repo24.setPreference<bool>(PreferenceKeys.is24, newValue);
  }

  bool is24Enabled(bool newValue) {
    final saved = _repo24.getPreference<bool>(PreferenceKeys.is24);
    return newValue == null ? saved == null ? true : saved : newValue;
  }

  List<String> getTimeString({String x}) {
    String saved = _sleepTimeRepo.getPreference<String>(PreferenceKeys.sleepingTime);
    return x == null ? saved == null ? ['10:00-PM', '06:00-AM'] : saved.split('|') : x.split('|');
  }

  void onFromBedChanged(DateTime dateTime) {
    String fromBed = '${getTimeString()[0]}|${getTimeInMeridian(dateTime)}';
    _sleepTimeRepo.updateStream(StringModel(data: fromBed));
    _sleepTimeRepo.setPreference<String>(PreferenceKeys.sleepingTime, fromBed);
  }

  void onToBedChanged(DateTime dateTime) {
    String toBed = '${getTimeInMeridian(dateTime)}|${getTimeString()[1]}';
    _sleepTimeRepo.updateStream(StringModel(data: toBed));
    _sleepTimeRepo.setPreference<String>(PreferenceKeys.sleepingTime, toBed);
  }

  String getToBedTrailing(String snapShot) {
    return snapShot == null ? getTimeString()[0] : getTimeString(x: snapShot)[0];
  }

  String getFromBedTrailing(String snapShot) {
    return snapShot == null ? getTimeString()[1] : getTimeString(x: snapShot)[1];
  }

  int getRemainingTime() {
    DateTime toBed = mapTime(getTimeString()[0]);
    DateTime now = DateTime.now();
    int minuteDifference = toBed.minute - now.minute;
    int hourDifference = toBed.hour - now.hour;
    if (minuteDifference < 0) minuteDifference += 60;
    if (hourDifference < 0) hourDifference += 24;
    return minuteDifference + (hourDifference * 60);
  }
  int getSleepingTimeRange(){
    DateTime toBed = mapTime(getTimeString()[0]);
    DateTime fromBed = mapTime(getTimeString()[1]);
    int minuteDifference = toBed.minute - fromBed.minute;
    int hourDifference = toBed.hour - fromBed.hour;
    if (minuteDifference < 0) minuteDifference += 60;
    if (hourDifference < 0) hourDifference += 24;
    return minuteDifference + (hourDifference * 60);
  }

  IconData getNotificationIcon(String snapShot) {
    if (alarmGroupValue(snapShot) == "Silent")
      return Icons.volume_off;
    else if (alarmGroupValue(snapShot) == "Vibrate")
      return Icons.vibration;
    else if (alarmGroupValue(snapShot) == "Sound")
      return Icons.volume_up;
    else
      return Icons.notifications;
  }

  String getTimeInMeridian(DateTime dateTime) {
    print(dateTime.hour);
    int hour = dateTime.hour;
    if (hour == 0)
      return '${12}:${dateTime.minute}-AM';
    else if (hour < 12)
      return '$hour:${dateTime.minute}-AM';
    else if(hour ==12)
      return '$hour:${dateTime.minute}-PM';
    else
      return '${hour - 12}:${dateTime.minute}-PM';
  }

  DateTime mapTime(String timeString) {
    List<String> initial = timeString.split('-');
    List<String> time = initial[0].split(':');
    final now = DateTime.now();
    if (time[0] == '0' || time[0] == '12')
      return DateTime(now.year, now.month, now.day, 12, int.parse(time[1]));
    else if (initial[1] == 'AM') {
      return DateTime(now.year, now.month, now.day, int.parse(time[0]), int.parse(time[1]));
    }
    return DateTime(now.year, now.month, now.day, int.parse(time[0]) - 12, int.parse(time[1]));
  }

  @override
  void dispose() {}
}
