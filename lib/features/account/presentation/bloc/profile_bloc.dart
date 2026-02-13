import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/account_user_entity.dart';
import '../../domain/repositories/account_repository.dart';
import 'package:image_picker/image_picker.dart';
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

    on<UploadProfileImageEvent>((event, emit) async {
      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(
        source: event.source,
        imageQuality: 75,
      );

      if (pickedFile == null) return;

      await repository.updateProfileImage(pickedFile.path);

      final updatedUser = await repository.getUser();

      if (updatedUser != null) {
        emit(AccountLoaded(updatedUser));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      print("@@UpdateProfileEvent@@");
      final fullName = event.fullName.trim();
      final phone = event.phone.trim();
      final email = event.email.trim();

      /// 1️⃣ Empty validation
      if (fullName.isEmpty ||
          phone.isEmpty ||
          email.isEmpty) {
        emit(const UpdateProfileFailure(
            "Tous les champs sont obligatoires."));
        return;
      }

      /*/// 2️⃣ Phone validation
      final phoneRegex = RegExp(r'^[0-9]{8,15}$');
      if (!phoneRegex.hasMatch(phone)) {
        emit(const UpdateProfileFailure(
            "Numéro WhatsApp invalide."));
        return;
      }*/

      /*/// 3️⃣ Email validation
      final emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      if (!emailRegex.hasMatch(email)) {
        emit(const UpdateProfileFailure(
            "Adresse e-mail invalide."));
        return;
      }*/

      emit(UpdateProfileLoading());

      try {

        await repository.updateProfile(
          fullName: fullName,
          phone: phone,
          email: email,
        );

        final updatedUser = await repository.getUser();

        if (updatedUser != null) {

          emit(UpdateProfileSuccess());

          /// Emit loaded state so UI refreshes
          emit(AccountLoaded(updatedUser));
        }

      } catch (e) {
        emit(const UpdateProfileFailure(
            "Erreur lors de la mise à jour."));
      }
    });

  }
}
