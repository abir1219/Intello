part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class SubmitChangePassword extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const SubmitChangePassword({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword, confirmPassword];
}
