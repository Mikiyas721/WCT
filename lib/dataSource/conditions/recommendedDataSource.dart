import '../../models/double.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class RecommendedRepo extends ItemRepo<DoubleModel>{
  RecommendedRepo(BehaviorSubject<JSONModel> subject) : super(subject);
}