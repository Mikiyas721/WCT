import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class MealFluidRepo extends ItemRepo {
  MealFluidRepo(BehaviorSubject<JSONModel> subject) : super(subject);
}
