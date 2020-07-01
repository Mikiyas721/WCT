import '../../models/boolean.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class NotificationRepo extends ItemRepo<BooleanModel> {
  NotificationRepo(BehaviorSubject<JSONModel> subject) : super(subject);
}
