import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:instagram_clone/core/error/exception_handler.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_up_request_dto.dart';
import 'package:instagram_clone/core/di/di_container.dart';
import 'package:instagram_clone/core/error/failure.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_in_request_dto.dart';
import 'package:instagram_clone/features/authentication/domain/entity/user_entity.dart';

abstract class AuthNetworkSource {
  AuthNetworkSource();

  Future<Either<BaseFailure, UserEntity>> signInWithEmailPassword(
    SignInRequestDto dto,
  );
  Future<Either<AuthFailure, UserEntity>> signUpWithEmail(
    SignUpRequestDto dto,
  );
  Future<bool> signInWithGoogle();
}

class AuthNetworkSourceImpl implements AuthNetworkSource {
  AuthNetworkSourceImpl();

  @override
  Future<Either<BaseFailure, UserEntity>> signInWithEmailPassword(
    SignInRequestDto dto,
  ) async {
    try {
      final supabase = di.get<SupabaseClient>();
      final response = await supabase.auth.signInWithPassword(
        email: dto.email,
        password: dto.password,
      );
      if (response.session != null) {
        return Right(
          UserEntity(
            id: response.session?.user.id ?? '',
            email: response.session?.user.email ?? '',
            accessToken: response.session?.accessToken ?? '',
          ),
        );
      } else {
        return const Left(
          AuthFailure(
            message: 'Invalid email or password',
          ),
        );
      }
    } on Exception catch (e) {
      final failure = ExceptionHandler.handleException(e);
      return Left(failure);
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signUpWithEmail(
    SignUpRequestDto dto,
  ) async {
    try {
      final supabase = di.get<SupabaseClient>();
      final response = await supabase.auth.signUp(
        email: dto.email,
        password: dto.password,
      );
      if (response.session != null) {
        return Right(
          UserEntity(
            id: response.session?.user.id ?? '',
            email: response.session?.user.email ?? '',
            accessToken: response.session?.accessToken ?? '',
          ),
        );
      } else {
        return const Left(
          AuthFailure(
            message: 'Invalid email or password',
          ),
        );
      }
    } on AuthApiException catch (e) {
      final failure = ExceptionHandler.handleException(e) as AuthFailure;
      return Left(failure);
    }
  }

  @override
  Future<bool> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
