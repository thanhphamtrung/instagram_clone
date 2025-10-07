import 'package:instagram_clone/core/di/di_container.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_in_request_dto.dart';
import 'package:instagram_clone/features/authentication/domain/reponsitory/auth_repository.dart';

class SignInWithEmailPassword {
  SignInWithEmailPassword(this.email, this.password);

  final String email;
  final String password;

  final AuthRepository authRepository = di.get<AuthRepository>();

  Future<bool> call() async {
    final result = await authRepository.signInWithEmailPassword(
      SignInRequestDto(email: email, password: password),
    );
    return result;
  }
}
