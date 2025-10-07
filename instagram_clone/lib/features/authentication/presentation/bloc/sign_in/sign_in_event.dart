part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent extends Equatable {}

final class SignInEmailEvent extends SignInEvent {
  SignInEmailEvent(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

final class SignInGoogleEvent extends SignInEvent {
  @override
  List<Object?> get props => [];
}
