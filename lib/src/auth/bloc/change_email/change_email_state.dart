part of 'change_email_bloc.dart';

sealed class ChangeEmailState {}

class ChangeEmailInitial extends ChangeEmailState {}

class ChangeEmailLoading extends ChangeEmailState {}

class ChangeEmailError extends ChangeEmailState {
  final String error;
  ChangeEmailError({required this.error});
}

class ChangeEmailSuccess extends ChangeEmailState {}
