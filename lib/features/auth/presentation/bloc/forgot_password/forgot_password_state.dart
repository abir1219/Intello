part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ValidatePhoneSuccess extends ForgotPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ValidatePhoneFailure extends ForgotPasswordState {
  final String message;

  const ValidatePhoneFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;

  const ForgotPasswordFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
