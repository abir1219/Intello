part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}
class LoginUserEvent extends LoginEvent {
  final String phone;
  final String email;
  final String password;

  const LoginUserEvent({
    required this.email,
    required this.password, required this.phone,
  });

  @override
  List<Object?> get props => [email,password,phone];
}
