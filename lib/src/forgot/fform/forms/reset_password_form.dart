import 'package:fform/fform.dart';

import '../../../auth/export.dart';

class ResetForm extends FForm {
  final EmailField email;
  final PasswordField password;

  ResetForm({required this.email, required this.password});

  factory ResetForm.parse({
    required String email,
    required String password,
  }) {
    return ResetForm(
      email: EmailField(value: email),
      password: PasswordField(value: password),
    );
  }

  @override
  bool get allFieldUpdateCheck => false;

  @override
  List<FFormField> get fields => [email, password];
}
