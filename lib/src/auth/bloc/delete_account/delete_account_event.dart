part of 'delete_account_bloc.dart';

sealed class DeleteAccountEvent {}

class DeleteAccount extends DeleteAccountEvent {
  final DeleteAccountParams params;
  DeleteAccount({required this.params});
}
