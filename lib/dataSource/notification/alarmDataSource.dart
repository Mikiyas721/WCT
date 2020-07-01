import '../../models/conditions.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class AlarmRepo extends ItemRepo<StringModel> {
  AlarmRepo(BehaviorSubject<JSONModel> subject) : super(subject);
}
