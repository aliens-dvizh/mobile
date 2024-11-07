part of 'change_email_bloc.dart';

sealed class ChangeEmailState {}

class ChangeEmailInitial extends ChangeEmailState {}

class ChangeEmailLoading extends ChangeEmailState {}

class ChangeEmailError extends ChangeEmailState {
  ChangeEmailError({required this.error});
  final String error;
}

class ChangeEmailSuccess extends ChangeEmailState {}
