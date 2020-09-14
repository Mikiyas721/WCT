import 'package:Nutracker/core/repository.dart';
import 'package:rxdart/rxdart.dart';

class StatRepo extends ListRepo<Map<String, dynamic>>{
  StatRepo(BehaviorSubject<List<Map<String, dynamic>>> subject) : super(subject);
}