part of 'delete_account_bloc.dart';

sealed class DeleteAccountEvent {}

class DeleteAccount extends DeleteAccountEvent {
  DeleteAccount({required this.params});
  final DeleteAccountParams params;
}
