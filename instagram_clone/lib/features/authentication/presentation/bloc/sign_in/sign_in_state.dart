part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState extends Equatable {}

final class SignInInitial extends SignInState {
  @override
  List<Object?> get props => [];
}

final class SignInLoading extends SignInState {
  @override
  List<Object?> get props => [];
}

final class SignInSuccess extends SignInState {
  @override
  List<Object?> get props => [];
}

final class SignInFailure extends SignInState {
  SignInFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
