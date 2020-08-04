import '../../models/string.dart';
import '../../core/jsonModel.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/repository.dart';

class SleepTimeRepo extends ItemRepo<StringModel>{
  SleepTimeRepo(BehaviorSubject<JSONModel> subject) : super(subject);
}