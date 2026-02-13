part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();
}

final class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationLoading extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationSuccess extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationFailure extends RegistrationState {
  final String message;

  const RegistrationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
