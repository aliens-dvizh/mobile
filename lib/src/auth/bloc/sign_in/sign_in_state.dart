part of 'sign_in_cubit.dart';

sealed class SignInState {}

class SignLoginState extends SignInState {}

class SingVerifyState extends SignInState {
  SingVerifyState(this.email);

  final String email;
}

class SingRegisterState extends SignInState {}
