import 'package:dartz/dartz.dart';
import 'package:instagram_clone/core/error/failure.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_up_request_dto.dart';
import 'package:instagram_clone/features/authentication/domain/entity/user_entity.dart';
import 'package:instagram_clone/features/authentication/domain/repository/auth_repository.dart';

class SignUpWithEmail {
  SignUpWithEmail(this._authRepository);

  final AuthRepository _authRepository;

  Future<Either<AuthFailure, UserEntity>> call({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // Validation
    if (email.isEmpty || password.isEmpty) {
      return const Left(
        AuthFailure(message: 'Email and password are required'),
      );
    }

    if (password != confirmPassword) {
      return const Left(AuthFailure(message: 'Passwords do not match'));
    }

    // Call repository
    final result = await _authRepository.signUpWithEmail(
      SignUpRequestDto(email: email, password: password),
    );

    return result.fold(
      Left.new,
      (success) async {
        await _authRepository.saveAccessToken(success.accessToken);
        return Right(success);
      },
    );
  }
}
