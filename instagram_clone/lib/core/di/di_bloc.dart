import 'package:get_it/get_it.dart';

import 'package:instagram_clone/features/authentication/presentation/bloc/sign_in/sign_in_bloc.dart';

class DiBloc {
  static Future<void> registerBlocs(GetIt di) async {
    di.registerSingleton<SignInBloc>(SignInBloc());
  }
}
