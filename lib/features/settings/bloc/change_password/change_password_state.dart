part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {

  final bool isLoading;
  final bool isSuccess;

  final bool isOldPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;

  final String? errorMessage;

  const ChangePasswordState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isOldPasswordVisible = true,
    this.isNewPasswordVisible = true,
    this.isConfirmPasswordVisible = true,
    this.errorMessage,
  });

  ChangePasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isOldPasswordVisible,
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isOldPasswordVisible:
      isOldPasswordVisible ?? this.isOldPasswordVisible,
      isNewPasswordVisible:
      isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible:
      isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isOldPasswordVisible,
    isNewPasswordVisible,
    isConfirmPasswordVisible,
    errorMessage,
  ];
}