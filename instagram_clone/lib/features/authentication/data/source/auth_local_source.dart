import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalSource {
  AuthLocalSource();

  Future<void> saveAccessToken(String accessToken) async {
    await const FlutterSecureStorage().write(
      key: 'access_token',
      value: accessToken,
    );
  }

  Future<String> getAccessToken() async {
    return await const FlutterSecureStorage().read(key: 'access_token') ?? '';
  }

  Future<void> deleteAccessToken() async {
    await const FlutterSecureStorage().delete(key: 'access_token');
  }
}
