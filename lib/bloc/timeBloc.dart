import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../core/mixins/notification.dart';
import '../models/string.dart';
import '../resources/preferenceKeys.dart';
import 'package:get_it/get_it.dart';
import '../dataSource/notification/timeDataSource.dart';
import '../core/utils/disposable.dart';

class TimeBloc extends Disposable with NotificationMixin {
  TimeRepo _timeRepo = GetIt.instance.get();

  Stream<String> get timeStream => _timeRepo.getStream<String>((value) => value);

  String getTimeGroupValue(String value) {
    return value == null ? _timeRepo.getPreference<String>(PreferenceKeys.time) : value;
  }

  void onTimeChanged(String newValue) {
    _timeRepo.updateStream(StringModel(data: newValue));
    _timeRepo.setPreference<String>(PreferenceKeys.time, newValue);
  }

  int getCountDownTime(String data) {
    return data == null ? mapTimeString(_timeRepo.getPreference<String>(PreferenceKeys.time)) : mapTimeString(data);
  }

  int mapTimeString(String data) {
    if (data == '20 Minutes')
      return 20;
    else if (data == '40 Minutes')
      return 40;
    else if (data == '60 Minutes')
      return 60;
    else if (data == '90 Minutes')
      return 90;
    else if (data == '2 Hours')
      return 120;
    else if (data == '3 Hours')
      return 180;
    else
      return 240;
  }

  void onTimerDone() async {
    bool isDisabled = _timeRepo.getPreference<bool>(PreferenceKeys.isNotificationDisabled);
    if (!isDisabled) {
      if (_timeRepo.getPreference<bool>(PreferenceKeys.notify)) notification();
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
