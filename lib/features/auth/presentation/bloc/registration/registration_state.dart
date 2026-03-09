part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const RegistrationState({
    this.isPasswordVisible = true,
    this.isConfirmPasswordVisible = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RegistrationState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegistrationState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
      isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isPasswordVisible,
    isConfirmPasswordVisible,
    isLoading,
    isSuccess,
    errorMessage,
  ];
}