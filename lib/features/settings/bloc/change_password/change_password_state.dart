part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

final class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordLoading extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordSuccess extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordFailure extends ChangePasswordState {
  final String message;

  const ChangePasswordFailure(this.message);

  @override
  List<Object?> get props => [message];
}
