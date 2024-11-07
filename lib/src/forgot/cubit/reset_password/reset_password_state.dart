part of 'reset_password_cubit.dart';

sealed class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordError extends ResetPasswordState {
  ResetPasswordError(this.message);
  final String message;
}
