import 'package:instagram_clone/features/authentication/data/dto/sign_in_request_dto.dart';

abstract class AuthRepository {
  AuthRepository();

  Future<bool> signInWithEmailPassword(SignInRequestDto dto);
  Future<bool> signInWithGoogle();
}
