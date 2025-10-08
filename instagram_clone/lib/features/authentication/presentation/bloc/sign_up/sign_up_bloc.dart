import 'package:bloc/bloc.dart';
import 'package:instagram_clone/core/di/di_container.dart';
import 'package:instagram_clone/features/authentication/domain/repository/auth_repository.dart';
import 'package:instagram_clone/features/authentication/domain/usecase/sign_up_with_email.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEmailEvent>(_onSignUpEmail);
  }

  Future<void> _onSignUpEmail(
    SignUpEmailEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      final result =
          await SignUpWithEmail(
            di.get<AuthRepository>(),
          ).call(
            email: event.email,
            password: event.password,
            confirmPassword: event.confirmPassword,
          );

      result.fold(
        (failure) => emit(SignUpFailure(failure.message)),
        (success) => emit(SignUpSuccess()),
      );
    } on Exception catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
