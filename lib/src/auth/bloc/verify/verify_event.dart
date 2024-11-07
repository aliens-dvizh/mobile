part of 'verify_bloc.dart';

sealed class VerifyEvent {}

class VerifyFetch extends VerifyEvent {
  VerifyFetch(this.params);
  final VerifyParams params;
}

class ResendVerificationCode extends VerifyEvent {
  ResendVerificationCode(this.email);
  final String email;
}
