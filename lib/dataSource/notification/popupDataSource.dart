import '../../models/boolean.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class PopUpRepo extends ItemRepo<BooleanModel> {
  PopUpRepo(BehaviorSubject<JSONModel> subject) : super(subject);
}
