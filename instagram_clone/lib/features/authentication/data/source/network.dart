import 'package:instagram_clone/core/di/di_container.dart';
import 'package:instagram_clone/features/authentication/data/dto/sign_in_request_dto.dart';
import 'package:instagram_clone/features/authentication/domain/reponsitory/auth_repository.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthNetworkSource implements AuthRepository {
  AuthNetworkSource();

  @override
  Future<bool> signInWithEmailPassword(SignInRequestDto dto) async {
    final supabase = di.get<SupabaseClient>();
    final response = await supabase.auth.signInWithPassword(
      email: dto.email,
      password: dto.password,
    );
    if (response.session != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
