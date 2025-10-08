import 'package:dio/dio.dart';
import 'package:instagram_clone/core/config/environment.dart';
import 'package:instagram_clone/core/di/di_container.dart';
import 'package:instagram_clone/features/authentication/data/source/auth_local_source.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await di.get<AuthLocalSource>().getAccessToken();

    options.headers['apikey'] = Environment.supabaseAnonKey;
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await di.get<AuthLocalSource>().deleteAccessToken();
    }
    super.onError(err, handler);
  }
}
