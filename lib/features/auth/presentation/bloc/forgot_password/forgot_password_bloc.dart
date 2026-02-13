import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository repository;

  ForgotPasswordBloc(this.repository) : super(ForgotPasswordInitial()) {
    on<SubmitForgotPassword>((event, emit) async {
      emit(ForgotPasswordLoading());

      await repository
          .forgotPasswordSubmit(event.newPassword)
          .then((value) => emit(ForgotPasswordSuccess()))
          .onError(
            (error, stackTrace) => emit(
              ForgotPasswordFailure("Aucun compte associé à cet email."),
            ),
          );

      /*final exists =
      await repository.forgotPassword(event.newPassword);

      if (exists) {
        emit(ForgotPasswordSuccess());
      } else {
        emit(ForgotPasswordFailure(
            "Aucun compte associé à cet email."));
      }*/
    });

    on<ValidatePhoneNumberEvent>((event, emit) async {
      if (event.phone.isEmpty) {
        emit(ValidatePhoneFailure("Veuillez entrer votre email."));
        return;
      }

      /*final emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      if (!emailRegex.hasMatch(event.email)) {
        emit(ForgotPasswordFailure(
            "Adresse e-mail invalide."));
        return;
      }*/

      emit(ForgotPasswordLoading());

      final exists = await repository.forgotPassword(event.phone);

      if (exists) {
        emit(ValidatePhoneSuccess());
      } else {
        emit(ForgotPasswordFailure("Aucun compte associé à cet email."));
      }
    });
  }
}
