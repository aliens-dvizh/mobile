part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String email;

  ForgotPasswordSuccess({required this.email});
}

class CheckVerificationCodeSuccess extends ForgotPasswordState {
  final String email;

  CheckVerificationCodeSuccess({required this.email});
}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  ForgotPasswordError(this.message);
}
