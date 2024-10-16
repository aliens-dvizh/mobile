part of 'change_email_bloc.dart';

sealed class ChangeEmailEvent {}

class ChangeEmail extends ChangeEmailEvent {
  final ChangeEmailParams params;
  ChangeEmail({required this.params});
}
