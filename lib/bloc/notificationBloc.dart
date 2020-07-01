import '../dataSource/notification/alarmDataSource.dart';
import '../dataSource/notification/notificationDataSource.dart';
import '../dataSource/notification/popupDataSource.dart';
import '../models/boolean.dart';
import '../resources/preferenceKeys.dart';
import 'package:get_it/get_it.dart';
import '../dataSource/notification/disableNotificationDataSource.dart';
import '../core/utils/disposable.dart';

class NotificationBloc extends Disposable {
  DisableNotificationRepo _disableNotificationRepo = GetIt.instance.get();
  NotificationRepo _notificationRepo = GetIt.instance.get();
  PopUpRepo _popUpRepo = GetIt.instance.get();
  AlarmRepo _alarmRepo = GetIt.instance.get();

  void onDisableTap(bool newValue) {
    _disableNotificationRepo.updateStream(BooleanModel(newValue));
    _disableNotificationRepo.setPreference<bool>(
        PreferenceKeys.disableNotification, newValue);
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

  bool notificationValue(bool snapshot) {
    bool x = _notificationRepo.getPreference<bool>(PreferenceKeys.notification);
    return snapshot == null ? x ? false : x : snapshot;
  }

  bool popupValue(bool snapshot) {
    bool x = _popUpRepo.getPreference<bool>(PreferenceKeys.popupNotification);
    return snapshot == null ? x == null ? false : x : snapshot;
  }

  String alarmGroupValue(String snapshot) {
    return snapshot == null
        ? _alarmRepo.getPreference<bool>(PreferenceKeys.alarm)
        : snapshot;
  }

  void onAlarmSubmitted() {}

  @override
  void dispose() {}
}
