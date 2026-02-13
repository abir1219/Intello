part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadAccountEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class UploadProfileImageEvent extends ProfileEvent {
  final ImageSource source;

  const UploadProfileImageEvent(this.source);

  @override
  List<Object?> get props => [source];
}

class UpdateProfileEvent extends ProfileEvent {
  final String fullName;
  final String phone;
  final String email;

  const UpdateProfileEvent({
    required this.fullName,
    required this.phone,
    required this.email,
  });

  @override
  List<Object?> get props => [fullName, phone, email];
}
