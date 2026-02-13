part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class AccountLoading extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AccountLoaded extends ProfileState {
  final AccountUserEntity user;
  const AccountLoaded(this.user);

  @override
  // TODO: implement props
  List<Object?> get props =>  [user];
}

class AccountFailure extends ProfileState {
  final String message;
  const AccountFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props =>  [message];
}

class UpdateProfileLoading extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateProfileSuccess extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateProfileFailure extends ProfileState {
  final String message;
  const UpdateProfileFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props =>  [message];
}