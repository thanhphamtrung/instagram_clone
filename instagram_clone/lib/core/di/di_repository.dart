import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:instagram_clone/features/authentication/data/source/auth_local_source.dart';
import 'package:instagram_clone/features/authentication/data/source/auth_network_source.dart';

import 'package:instagram_clone/features/authentication/domain/repository/auth_repository.dart';

class DiRepository {
  static Future<void> registerRepositories(GetIt di) async {
    di.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(
        authNetworkSource: di.get<AuthNetworkSource>(),
        authLocalSource: di.get<AuthLocalSource>(),
      ),
    );
  }
}
