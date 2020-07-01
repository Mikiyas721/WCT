import '../models/conditions.dart';
import 'package:rxdart/rxdart.dart';
import '../core/jsonModel.dart';
import '../core/repository.dart';

class TimeRepo extends ItemRepo<StringModel> {
  TimeRepo(BehaviorSubject<JSONModel> subject) : super(subject);
}
