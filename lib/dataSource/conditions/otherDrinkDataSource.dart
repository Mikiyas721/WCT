import 'package:rxdart/rxdart.dart';
import '../../core/jsonModel.dart';
import '../../core/repository.dart';

class OtherDrinksRepo extends ItemRepo{
  OtherDrinksRepo(BehaviorSubject<JSONModel> subject) : super(subject);

}