part of 'change_email_bloc.dart';

sealed class ChangeEmailEvent {}

class ChangeEmail extends ChangeEmailEvent {
  ChangeEmail({required this.params});
  final ChangeEmailParams params;
}
