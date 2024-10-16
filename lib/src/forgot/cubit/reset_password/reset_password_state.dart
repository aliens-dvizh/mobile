part of 'reset_password_cubit.dart';

sealed class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordError extends ResetPasswordState {
  final String message;

  ResetPasswordError(this.message);
}
