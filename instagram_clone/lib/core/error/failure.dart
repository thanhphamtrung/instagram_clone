abstract class Failure {
  const Failure();
}

class AuthFailure extends Failure {
  const AuthFailure(this.message);

  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}
