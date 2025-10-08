import 'package:dartz/dartz.dart';
import 'package:instagram_clone/core/di/di_container.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_in_request_dto.dart';
import 'package:instagram_clone/features/authentication/domain/entity/user_entity.dart';
import 'package:instagram_clone/features/authentication/domain/repository/auth_repository.dart';

class SignInWithEmailPassword {
  SignInWithEmailPassword(this.email, this.password);

  final String email;
  final String password;

  final AuthRepository authRepository = di.get<AuthRepository>();

  Future<Either<String, UserEntity>> call() async {
    final result = await authRepository.signInWithEmailPassword(
      SignInRequestDto(email: email, password: password),
    );

    return result.fold(
      (failure) => Left(failure.message),
      (success) async {
        await authRepository.saveAccessToken(success.accessToken);
        return Right(success);
      },
    );
  }
}
