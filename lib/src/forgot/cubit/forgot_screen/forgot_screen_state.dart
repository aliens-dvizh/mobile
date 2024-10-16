part of 'forgot_screen_cubit.dart';

sealed class ForgotScreenState {}

class SendCodeScreenState extends ForgotScreenState {}

class VerifyCodeScreenState extends ForgotScreenState {}

class ResetPasswordScreenState extends ForgotScreenState {}

class SuccessPasswordScreenState extends ForgotScreenState {}
