import 'package:rxdart/rxdart.dart';
import '../../core/repository.dart';
import '../../models/boolean.dart';

class Repo24 extends ItemRepo<BooleanModel>{
  Repo24(BehaviorSubject<BooleanModel> subject) : super(subject);
}