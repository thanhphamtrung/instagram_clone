import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/di/di_bloc.dart';
import 'package:instagram_clone/core/di/di_data_source.dart';
import 'package:instagram_clone/core/di/di_repository.dart';

final GetIt di = GetIt.instance;

class DiContainer {
  static Future<void> init() async {
    await DiDataSource.registerDataSources(di);
    await DiRepository.registerRepositories(di);
    await DiBloc.registerBlocs(di);
  }
}
