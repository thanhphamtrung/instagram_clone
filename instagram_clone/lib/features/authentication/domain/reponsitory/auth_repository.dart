import 'package:dartz/dartz.dart';

import 'package:instagram_clone/core/error/failure.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_in_request_dto.dart';
import 'package:instagram_clone/features/authentication/domain/entity/user_entity.dart';

abstract class AuthRepository {
  AuthRepository();

  Future<Either<AuthFailure, UserEntity>> signInWithEmailPassword(
    SignInRequestDto dto,
  );
  Future<bool> signInWithGoogle();
}
