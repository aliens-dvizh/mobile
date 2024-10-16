part of 'verify_bloc.dart';

sealed class VerifyEvent {}

class VerifyFetch extends VerifyEvent {
  final VerifyParams params;

  VerifyFetch(this.params);
}

class ResendVerificationCode extends VerifyEvent {
  final String email;

  ResendVerificationCode(this.email);
}
