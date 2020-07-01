import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class WeightRepo extends ItemRepo{
  WeightRepo(BehaviorSubject<JSONModel> subject) : super(subject);

}