import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/domain/repositories/auth_repository.dart';


part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {

  final AuthRepository repository;

  ChangePasswordBloc(this.repository)
      : super(ChangePasswordInitial()) {

    on<SubmitChangePassword>((event, emit) async {

      if (event.currentPassword.isEmpty ||
          event.newPassword.isEmpty ||
          event.confirmPassword.isEmpty) {
        emit(ChangePasswordFailure("Tous les champs sont obligatoires."));
        return;
      }

      /*if (event.newPassword.length < 6) {
        emit(ChangePasswordFailure(
            "Le mot de passe doit contenir au moins 6 caractères."));
        return;
      }*/

      if (event.newPassword != event.confirmPassword) {
        emit(ChangePasswordFailure(
            "Les mots de passe ne correspondent pas."));
        return;
      }

      emit(ChangePasswordLoading());

      final result = await repository.changePassword(
        event.currentPassword,
        event.newPassword,
      );

      if (result) {
        emit(ChangePasswordSuccess());
      } else {
        emit(ChangePasswordFailure(
            "Mot de passe actuel incorrect."));
      }
    });
  }
}

