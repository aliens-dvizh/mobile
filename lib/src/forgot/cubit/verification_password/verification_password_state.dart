part of 'verification_password_cubit.dart';

sealed class VerificationPasswordState {}

class VerificationPasswordInitial extends VerificationPasswordState {}

class VerificationPasswordLoading extends VerificationPasswordState {}

class VerificationPasswordSuccess extends VerificationPasswordState {}

class VerificationPasswordError extends VerificationPasswordState {
  VerificationPasswordError(this.message);
  final String message;
}
