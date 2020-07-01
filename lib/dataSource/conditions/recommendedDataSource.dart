import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class RecommendedRepo extends ItemRepo{
  RecommendedRepo(BehaviorSubject<JSONModel> subject) : super(subject);

}