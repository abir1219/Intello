part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}
class LoadAccountEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
