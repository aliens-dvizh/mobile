part of 'get_code_change_email_bloc.dart';

sealed class ChangeEmailEvent {}

class GetCodeChangeEmail extends ChangeEmailEvent {
  GetCodeChangeEmail({required this.params});
  final CodeToChangeEmailParams params;
}
