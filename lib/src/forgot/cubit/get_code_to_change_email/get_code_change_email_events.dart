part of 'get_code_change_email_bloc.dart';

sealed class ChangeEmailEvent {}

class GetCodeChangeEmail extends ChangeEmailEvent {
  final CodeToChangeEmailParams params;
  GetCodeChangeEmail({required this.params});
}
