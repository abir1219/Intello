import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/account_user_entity.dart';
import '../../domain/repositories/account_repository.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final AccountRepository repository;

  ProfileBloc(this.repository)
      : super(ProfileInitial()) {

    on<LoadAccountEvent>((event, emit) async {

      emit(AccountLoading());

      try {
        final user = await repository.getUser();

        if (user == null) {
          emit(AccountFailure("Utilisateur non trouvé."));
        } else {
          emit(AccountLoaded(user));
        }

      } catch (e) {
        emit(AccountFailure("Erreur lors du chargement."));
      }
    });
  }
}
