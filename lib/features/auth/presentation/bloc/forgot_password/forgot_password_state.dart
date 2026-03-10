part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isPhoneValidated;

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  final String? errorMessage;

  const ForgotPasswordState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isPhoneValidated = false,
    this.isPasswordVisible = true,
    this.isConfirmPasswordVisible = true,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isPhoneValidated,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isPhoneValidated: isPhoneValidated ?? this.isPhoneValidated,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
      isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isPhoneValidated,
    isPasswordVisible,
    isConfirmPasswordVisible,
    errorMessage,
  ];
}