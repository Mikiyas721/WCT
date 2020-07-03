import 'package:flutter/material.dart';
import '../models/string.dart';
import '../dataSource/notification/alarmDataSource.dart';
import '../dataSource/notification/nowExercisingDataSource.dart';
import '../dataSource/notification/notificationDataSource.dart';
import '../dataSource/notification/popupDataSource.dart';
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

  Stream<bool> get disableNotificationStream =>
      _disableNotificationRepo.getStream<bool>((newValue) => newValue);

  Stream<bool> get nowExercisingStream =>
      _nowExercisingRepo.getStream<bool>((newValue) => newValue);

  Stream<bool> get notificationStream =>
      _notificationRepo.getStream<bool>((newValue) => newValue);

  Stream<bool> get popupStream =>
      _popUpRepo.getStream<bool>((newValue) => newValue);

  Stream<String> get alarmStream =>
      _alarmRepo.getStream<String>((newValue) => newValue);

  void onDisableTap(bool newValue) {
    _disableNotificationRepo.updateStream(BooleanModel(newValue));
    _disableNotificationRepo.setPreference<bool>(
        PreferenceKeys.disableNotification, newValue);
  }

  void onNowExercisingTap(bool newValue) {
    _nowExercisingRepo.updateStream(BooleanModel(newValue));
    _nowExercisingRepo.setPreference<bool>(
        PreferenceKeys.nowExercising, newValue);
  }

  void onNotificationTap(bool newValue) {
    _notificationRepo.updateStream(BooleanModel(newValue));
    _notificationRepo.setPreference<bool>(
        PreferenceKeys.notification, newValue);
  }

  void onPopupTap(bool newValue) {
    _popUpRepo.updateStream(BooleanModel(newValue));
    _popUpRepo.setPreference<bool>(PreferenceKeys.popupNotification, newValue);
  }

  bool disableValue(bool snapshot) {
    bool x = _disableNotificationRepo
        .getPreference<bool>(PreferenceKeys.disableNotification);
    return snapshot == null ? x == null ? false : x : snapshot;
  }

  bool nowExercisingValue(bool snapshot) {
    bool x =
        _nowExercisingRepo.getPreference<bool>(PreferenceKeys.nowExercising);
    return snapshot == null ? x == null ? false : x : snapshot;
  }

  bool notificationValue(bool snapshot) {
    bool x = _notificationRepo.getPreference<bool>(PreferenceKeys.notification);
    return snapshot == null ? x == null ? false : x : snapshot;
  }

  bool popupValue(bool snapshot) {
    bool x = _popUpRepo.getPreference<bool>(PreferenceKeys.popupNotification);
    return snapshot == null ? x == null ? false : x : snapshot;
  }

  String alarmGroupValue(String snapshot) {
    return snapshot == null
        ? _alarmRepo.getPreference<String>(PreferenceKeys.alarm)
        : snapshot;
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
    else if (alarmState == "Vibrate") newAlarm = "Sound";
    else if (alarmState == "Sound") newAlarm = "Silent";
    _alarmRepo.updateStream(StringModel(data: newAlarm));
    _alarmRepo.setPreference<String>(PreferenceKeys.alarm, newAlarm);
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

  @override
  void dispose() {}
}
