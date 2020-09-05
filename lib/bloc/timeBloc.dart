import 'package:Nutracker/core/mixins/validator_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../core/mixins/notificationHandler.dart';
import '../models/string.dart';
import '../resources/preferenceKeys.dart';
import 'package:get_it/get_it.dart';
import '../dataSource/notification/timeDataSource.dart';
import '../core/utils/disposable.dart';

class TimeBloc extends Disposable {
  TimeRepo _timeRepo = GetIt.instance.get();

  Stream<String> get timeStream => _timeRepo.getStream<String>((value) => value);

  void updateTime(String time) {
    _timeRepo.updateStream(StringModel(data: time));
  }

  String getTimeGroupValue(String value) {
    return value == null ? _timeRepo.getPreference<String>(PreferenceKeys.time) : value;
  }

  void onTimeChanged(String newValue) {
    _timeRepo.updateStream(StringModel(data: newValue));
    _timeRepo.setPreference<String>(PreferenceKeys.time, newValue);
  }

  int getCountDownTime(String data) {
    return  data == null
        ? mapTimeString(_timeRepo.getPreference<String>(PreferenceKeys.time))
        : mapTimeString(data);
  }

  int mapTimeString(String data) {
    List<String> split = data.split(' ');
    if (split[1] == 'Minutes')
      return int.parse(split[0]);
    else
      return int.parse(split[0]) * 60;
  }

  void onTimerDone(BuildContext context) async {
    bool isDisabled = _timeRepo.getPreference<bool>(PreferenceKeys.isNotificationDisabled);
    if (!isDisabled) {
      if (_timeRepo.getPreference<bool>(PreferenceKeys.notify)) NotificationHandler(context: context).notify();
      String alarm = _timeRepo.getPreference<String>(PreferenceKeys.alarm);
      if (alarm == 'Vibrate') {
        // TODO Add code for vibration
      } else if (alarm == 'Sound') {
        FlutterRingtonePlayer.playAlarm(looping: true, asAlarm: false);
      }
    }
  }

  @override
  void dispose() {}
}
