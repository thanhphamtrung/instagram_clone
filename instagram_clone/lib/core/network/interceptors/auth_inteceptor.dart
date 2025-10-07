import 'package:dio/dio.dart';
import 'package:instagram_clone/core/config/environment.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // supabase key
    options.headers['Authorization'] = 'Bearer ${Environment.supabaseAnonKey}';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}
