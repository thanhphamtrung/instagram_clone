import 'package:dartz/dartz.dart';

import 'package:instagram_clone/core/error/failure.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_in_request_dto.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_up_request_dto.dart';
import 'package:instagram_clone/features/authentication/domain/entity/user_entity.dart';

abstract class AuthRepository {

  Future<void> saveAccessToken(String accessToken);

  Future<String> getAccessToken();

  Future<void> deleteAccessToken();

  Future<Either<BaseFailure, UserEntity>> signInWithEmailPassword(
    SignInRequestDto dto,
  );

  Future<Either<AuthFailure, UserEntity>> signUpWithEmail(
    SignUpRequestDto dto,
  );

  Future<bool> signInWithGoogle();
}
