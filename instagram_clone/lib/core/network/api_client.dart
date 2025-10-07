class ApiClient {
  factory ApiClient() => _instance;

  ApiClient._();

  static final ApiClient _instance = ApiClient._();

  static ApiClient get instance => _instance;
}
