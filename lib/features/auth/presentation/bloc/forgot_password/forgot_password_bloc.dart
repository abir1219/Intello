import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {

  final AuthRepository repository;

  ForgotPasswordBloc(this.repository)
      : super(const ForgotPasswordState()) {

    /// Validate phone number
    on<ValidatePhoneNumberEvent>((event, emit) async {

      if (event.phone.isEmpty) {
        emit(state.copyWith(
          errorMessage: "Veuillez entrer votre email.",
        ));
        return;
      }

      emit(state.copyWith(
        isLoading: true,
        errorMessage: null,
      ));

      try {
        final exists = await repository.forgotPassword(event.phone);

        if (exists) {
          emit(state.copyWith(
            isLoading: false,
            isPhoneValidated: true,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: "Aucun compte associé à cet email.",
          ));
        }

      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ));
      }
    });

    /// Submit new password
    on<SubmitForgotPassword>((event, emit) async {

      emit(state.copyWith(
        isLoading: true,
        errorMessage: null,
      ));

      try {

        await repository.forgotPasswordSubmit(event.newPassword);

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
        ));

      } catch (e) {

        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Erreur lors de la réinitialisation du mot de passe.",
        ));
      }
    });

    /// Toggle password visibility
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(
        isPasswordVisible: !state.isPasswordVisible,
      ));
    });

    /// Toggle confirm password visibility
    on<ToggleConfirmPasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(
        isConfirmPasswordVisible:
        !state.isConfirmPasswordVisible,
      ));
    });
  }
}