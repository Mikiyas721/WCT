import '../../models/string.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/repository.dart';

class AgeRepo extends ItemRepo<StringModel> {
  AgeRepo(BehaviorSubject<StringModel> subject) : super(subject);
}
