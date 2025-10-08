import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/authentication/domain/usecase/sign_in_with_email_password.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEmailEvent>(_onSignInEmailEvent);

    on<SignInGoogleEvent>(_onSignInGoogleEvent);
  }

  /// Sign in with email and password
  ///
  /// @param event - The event to sign in with email and password
  /// @param emit - The emitter to emit the state
  /// @return void
  Future<void> _onSignInEmailEvent(
    SignInEmailEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());

    try {
      final result = await SignInWithEmailPassword(
        event.email,
        event.password,
      ).call();

      if (result.id.isNotEmpty) {
        emit(SignInSuccess());
      } else {
        emit(SignInFailure('Invalid email or password'));
      }
    } on Exception catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }

  Future<void> _onSignInGoogleEvent(
    SignInGoogleEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
  }
}
