part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

/// Validate phone number
class ValidatePhoneNumberEvent extends ForgotPasswordEvent {
  final String phone;

  const ValidatePhoneNumberEvent(this.phone);

  @override
  List<Object?> get props => [phone];
}

/// Submit new password
class SubmitForgotPassword extends ForgotPasswordEvent {
  final String newPassword;

  const SubmitForgotPassword(this.newPassword);

  @override
  List<Object?> get props => [newPassword];
}

/// Toggle password visibility
class TogglePasswordVisibilityEvent extends ForgotPasswordEvent {
  const TogglePasswordVisibilityEvent();
}

/// Toggle confirm password visibility
class ToggleConfirmPasswordVisibilityEvent extends ForgotPasswordEvent {
  const ToggleConfirmPasswordVisibilityEvent();
}