import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:instagram_clone/core/di/di_container.dart';
import 'package:instagram_clone/core/error/failure.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_in_request_dto.dart';
import 'package:instagram_clone/features/authentication/domain/entity/user_entity.dart';
import 'package:instagram_clone/features/authentication/domain/reponsitory/auth_repository.dart';

class AuthNetworkSource implements AuthRepository {
  AuthNetworkSource();

  @override
  Future<Either<AuthFailure, UserEntity>> signInWithEmailPassword(
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
            email: response.session!.user.email!,
          ),
        );
      } else {
        return const Left(AuthFailure('Invalid email or password'));
      }
    } 
    // TODO: create exception handler in core2
    on AuthApiException catch (e) {
      return Left(AuthFailure(e.message));
    }
  }

  @override
  Future<bool> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
