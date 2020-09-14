import 'package:Nutracker/databaseManager.dart';

import '../core/utils/disposable.dart';
import '../dataSource/statDataSource.dart';
import 'package:get_it/get_it.dart';

class StatBloc extends Disposable{
  StatRepo _statRepo = GetIt.instance.get();

  void fetchData()async{
    DataBaseManager instance = DataBaseManager.instance;
    instance.openDataBase();
    return _statRepo.updateStream(await instance.fetchData());
  }
  @override
  void dispose() {
  }
}