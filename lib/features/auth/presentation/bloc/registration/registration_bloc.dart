import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'registration_state.dart';
part 'registration_event.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository repository;

  RegistrationBloc(this.repository) : super(const RegistrationState()) {

    /// Register User
    on<RegisterUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      try {
        final user = UserEntity(
          firstName: event.firstName,
          lastName: event.lastName,
          whatsapp: event.whatsapp,
          email: event.email,
          password: event.password,
        );

        await repository.register(user);

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ));
      }
    });

    /// Toggle Password Visibility
    on<TogglePasswordEvent>((event, emit) {
      emit(state.copyWith(
        isPasswordVisible: !state.isPasswordVisible,
      ));
    });

    /// Toggle Confirm Password Visibility
    on<ToggleConfirmPasswordEvent>((event, emit) {
      emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
      ));
    });
  }
}