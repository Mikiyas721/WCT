import '../../models/boolean.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class NowExercisingRepo extends ItemRepo<BooleanModel> {
  NowExercisingRepo(BehaviorSubject<JSONModel> subject) : super(subject);
}
