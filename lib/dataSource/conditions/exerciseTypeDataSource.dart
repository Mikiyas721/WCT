import '../../models/string.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/repository.dart';

class ExerciseTypeRepo extends ItemRepo<StringModel> {
  ExerciseTypeRepo(BehaviorSubject<StringModel> subject) : super(subject);
}