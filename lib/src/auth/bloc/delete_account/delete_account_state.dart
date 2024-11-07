part of 'delete_account_bloc.dart';

sealed class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountError extends DeleteAccountState {
  DeleteAccountError({required this.error});
  final String error;
}

class DeleteAccountSuccess extends DeleteAccountState {}

class DeleteAccountNetworkError extends DeleteAccountState {
  DeleteAccountNetworkError({required this.error});
  final String error;
}

class DeleteAccountValidationError extends DeleteAccountState {
  DeleteAccountValidationError(this.message);
  final String message;
}
