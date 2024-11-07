part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted({required this.params});
  final LoginParams params;
}
