import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/auth_repository.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {

    on<LoginUserEvent>((event, emit) async {

      if (event.email.isEmpty || event.password.isEmpty || event.phone.isEmpty) {
        emit(LoginFailure("Tous les champs sont obligatoires."));
        return;
      }

      emit(LoginLoading());

      final success = await repository.login(
        event.email,
        event.password,
      );

      if (success) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Email ou mot de passe incorrect."));
      }
    });
  }
}
