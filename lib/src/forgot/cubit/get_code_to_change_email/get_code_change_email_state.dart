part of 'get_code_change_email_bloc.dart';

sealed class GetCodeToChangeEmailState {}

class GetCodeToChangeEmailInitial extends GetCodeToChangeEmailState {}

class GetCodeToChangeEmailLoading extends GetCodeToChangeEmailState {}

class GetCodeToChangeEmailError extends GetCodeToChangeEmailState {
  final String error;
  GetCodeToChangeEmailError({required this.error});
}

class GetCodeToChangeEmailSuccess extends GetCodeToChangeEmailState {}
