part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}
class RegisterUserEvent extends RegistrationEvent {
  final String firstName;
  final String lastName;
  final String whatsapp;
  final String email;
  final String password;

  const RegisterUserEvent({
    required this.firstName,
    required this.lastName,
    required this.whatsapp,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [firstName,lastName,whatsapp,email,password];
}