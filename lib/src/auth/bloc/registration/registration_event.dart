part of 'registration_bloc.dart';

sealed class RegistrationEvent {}

class Register extends RegistrationEvent {
  final RegisterParams params;

  Register({required this.params});
}
