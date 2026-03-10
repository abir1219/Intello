part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

/// Submit change password
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
  List<Object?> get props =>
      [currentPassword, newPassword, confirmPassword];
}

/// Toggle current password visibility
class ToggleCurrentPasswordVisibilityEvent
    extends ChangePasswordEvent {
  const ToggleCurrentPasswordVisibilityEvent();
}

/// Toggle new password visibility
class ToggleNewPasswordVisibilityEvent
    extends ChangePasswordEvent {
  const ToggleNewPasswordVisibilityEvent();
}

/// Toggle confirm password visibility
class ToggleConfirmPasswordVisibilityEvent
    extends ChangePasswordEvent {
  const ToggleConfirmPasswordVisibilityEvent();
}