part of 'login_bloc.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginRedirectVerifyState extends LoginState {
  LoginRedirectVerifyState({required this.email});
  final String email;
}

class LoginError extends LoginState {
  LoginError(this.message);
  final String? message;
}

class LoginNetworkError extends LoginState {}

class LoginValidationError extends LoginState {}
