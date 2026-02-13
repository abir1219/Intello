part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class ValidatePhoneNumberEvent extends ForgotPasswordEvent{
  final String phone;

  const ValidatePhoneNumberEvent(this.phone);

  @override
  // TODO: implement props
  List<Object?> get props => [phone];
}

class SubmitForgotPassword extends ForgotPasswordEvent {
  final String newPassword;

  const SubmitForgotPassword(this.newPassword);

  @override
  List<Object?> get props => [newPassword];
}
