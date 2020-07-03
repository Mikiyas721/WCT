import '../../models/string.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/repository.dart';

class ExerciseLengthRepo extends ItemRepo<StringModel> {
  ExerciseLengthRepo(BehaviorSubject<StringModel> subject) : super(subject);
}