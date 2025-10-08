part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

final class SignUpEmailEvent extends SignUpEvent {
  SignUpEmailEvent(this.email, this.password, this.confirmPassword);

  final String email;
  final String password;
  final String confirmPassword;
}
