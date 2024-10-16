part of 'delete_account_bloc.dart';

sealed class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountError extends DeleteAccountState {
  final String error;

  DeleteAccountError({required this.error});
}

class DeleteAccountSuccess extends DeleteAccountState {}

class DeleteAccountNetworkError extends DeleteAccountState {
  final String error;

  DeleteAccountNetworkError({required this.error});
}

class DeleteAccountValidationError extends DeleteAccountState {
  final String message;

  DeleteAccountValidationError(this.message);
}
