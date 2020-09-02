import '../../models/double.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/repository.dart';

class ConsumedRepo extends ItemRepo<DoubleModel> {
  ConsumedRepo(BehaviorSubject<DoubleModel> subject) : super(subject);
}