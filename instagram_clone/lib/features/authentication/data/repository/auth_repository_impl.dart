import 'package:dartz/dartz.dart';
import 'package:instagram_clone/core/error/failure.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_in_request_dto.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_up_request_dto.dart';
import 'package:instagram_clone/features/authentication/data/source/auth_local_source.dart';
import 'package:instagram_clone/features/authentication/data/source/auth_network_source.dart';
import 'package:instagram_clone/features/authentication/domain/entity/user_entity.dart';
import 'package:instagram_clone/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authNetworkSource,
    required this.authLocalSource,
  });

  final AuthNetworkSource authNetworkSource;
  final AuthLocalSource authLocalSource;

  @override
  Future<Either<BaseFailure, UserEntity>> signInWithEmailPassword(
    SignInRequestDto dto,
  ) async {
    return authNetworkSource.signInWithEmailPassword(dto);
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signUpWithEmail(
    SignUpRequestDto dto,
  ) {
    return authNetworkSource.signUpWithEmail(dto);
  }

  @override
  Future<void> deleteAccessToken() {
    return authLocalSource.deleteAccessToken();
  }

  @override
  Future<String> getAccessToken() {
    return authLocalSource.getAccessToken();
  }

  @override
  Future<void> saveAccessToken(String accessToken) {
    return authLocalSource.saveAccessToken(accessToken);
  }

  @override
  Future<bool> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
