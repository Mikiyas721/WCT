import '../../models/double.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/repository.dart';

class SoFarRepo extends ItemRepo<DoubleModel> {
  SoFarRepo(BehaviorSubject<DoubleModel> subject) : super(subject);
}