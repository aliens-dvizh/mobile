part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  ForgotPasswordSuccess({required this.email});
  final String email;
}

class CheckVerificationCodeSuccess extends ForgotPasswordState {
  CheckVerificationCodeSuccess({required this.email});
  final String email;
}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordError extends ForgotPasswordState {
  ForgotPasswordError(this.message);
  final String message;
}
