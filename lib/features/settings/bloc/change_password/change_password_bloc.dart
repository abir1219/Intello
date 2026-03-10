import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/domain/repositories/auth_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {

  final AuthRepository repository;

  ChangePasswordBloc(this.repository)
      : super(const ChangePasswordState()) {

    /// Submit change password
    on<SubmitChangePassword>((event, emit) async {

      if (event.currentPassword.isEmpty ||
          event.newPassword.isEmpty ||
          event.confirmPassword.isEmpty) {

        emit(state.copyWith(
          errorMessage: "Tous les champs sont obligatoires.",
        ));
        return;
      }

      if (event.newPassword != event.confirmPassword) {
        emit(state.copyWith(
          errorMessage: "Les mots de passe ne correspondent pas.",
        ));
        return;
      }

      emit(state.copyWith(
        isLoading: true,
        errorMessage: null,
      ));

      try {

        final result = await repository.changePassword(
          event.currentPassword,
          event.newPassword,
        );

        if (result) {

          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
          ));

        } else {

          emit(state.copyWith(
            isLoading: false,
            errorMessage: "Mot de passe actuel incorrect.",
          ));

        }

      } catch (e) {

        emit(state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ));

      }
    });

    /// Toggle current password visibility
    on<ToggleCurrentPasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(
        isOldPasswordVisible: !state.isOldPasswordVisible,
      ));
    });

    /// Toggle new password visibility
    on<ToggleNewPasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(
        isNewPasswordVisible: !state.isNewPasswordVisible,
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