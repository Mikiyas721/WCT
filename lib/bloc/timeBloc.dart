import 'package:Nutracker/models/string.dart';

import '../resources/preferenceKeys.dart';
import 'package:get_it/get_it.dart';
import '../dataSource/timeDataSource.dart';
import '../core/utils/disposable.dart';

class TimeBloc extends Disposable {
  TimeRepo _timeRepo = GetIt.instance.get();

  Stream<String> get timeStream =>
      _timeRepo.getStream<String>((value) => value);

  String getTimeGroupValue(String value) {
    return value == null
        ? _timeRepo.getPreference<String>(PreferenceKeys.time)
        : value;
  }

  void onTimeChanged(String newValue) {
    _timeRepo.updateStream(StringModel(data: newValue));
    _timeRepo.setPreference<String>(PreferenceKeys.time, newValue);
  }

  @override
  void dispose() {}
}
