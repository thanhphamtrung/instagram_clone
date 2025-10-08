import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/authentication/data/source/auth_network_source.dart';

import 'package:instagram_clone/features/authentication/domain/reponsitory/auth_repository.dart';

class DiRepository {
  static Future<void> registerRepositories(GetIt di) async {
    di.registerSingleton<AuthRepository>(AuthNetworkSource());
  }
}
