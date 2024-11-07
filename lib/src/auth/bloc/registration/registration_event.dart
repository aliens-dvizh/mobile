part of 'registration_bloc.dart';

sealed class RegistrationEvent {}

class Register extends RegistrationEvent {
  Register({required this.params});
  final RegisterParams params;
}
