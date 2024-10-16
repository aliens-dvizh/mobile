part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final LoginParams params;

  LoginSubmitted({required this.params});
}
