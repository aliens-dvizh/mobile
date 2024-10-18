part of 'registration_bloc.dart';

sealed class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final String email;

  RegistrationSuccess({required this.email});
}

class RegistrationFailure extends RegistrationState {}

class RegistrationNetworkError extends RegistrationState {}

class RegistrationValidationError extends RegistrationState {}
