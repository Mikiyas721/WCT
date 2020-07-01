import '../../models/boolean.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class DisableNotificationRepo extends ItemRepo<BooleanModel> {
  DisableNotificationRepo(BehaviorSubject<JSONModel> subject) : super(subject);
}
