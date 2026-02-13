import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'registration_state.dart';
part 'registration_event.dart';

class RegistrationBloc
    extends Bloc<RegistrationEvent, RegistrationState> {

  final AuthRepository repository;

  RegistrationBloc(this.repository)
      : super(RegistrationInitial()) {

    on<RegisterUserEvent>((event, emit) async {
      emit(RegistrationLoading());

      try {
        final user = UserEntity(
          firstName: event.firstName,
          lastName: event.lastName,
          whatsapp: event.whatsapp,
          email: event.email,
          password: event.password,
        );

        await repository.register(user);

        emit(RegistrationSuccess());
      } catch (e) {
        emit(RegistrationFailure(e.toString()));
      }
    });
  }
}
