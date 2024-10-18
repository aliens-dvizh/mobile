part of 'sign_in_cubit.dart';

sealed class SignInState {}

class SignLoginState extends SignInState {}

class SingVerifyState extends SignInState {
  final String email;

  SingVerifyState(this.email);
}

class SingRegisterState extends SignInState {}
