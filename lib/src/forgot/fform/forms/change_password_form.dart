import 'package:fform/fform.dart';

import '../../../auth/export.dart';
import '../fields/export.dart';


class ConfirmPasswordForm extends FForm {
  PasswordField password;
  ConfirmPasswordField confirmPassword;

  ConfirmPasswordForm({required this.password, required this.confirmPassword});

  factory ConfirmPasswordForm.parse({
    required String? password,
    required String? confirmPassword,
  }) {
    return ConfirmPasswordForm(
      password: PasswordField(value: password ?? ''),
      confirmPassword: ConfirmPasswordField(
        value: confirmPassword ?? '',
        password: password ?? '',
      ),
    );
  }

  void change({String? password, String? confirmPassword, }) {
    String passwordValue = password ?? '';

    this.password.value = passwordValue;
    this.confirmPassword
      ..password = passwordValue
      ..value = confirmPassword ?? '';
  }

  @override
  List<FFormField> get fields => [password, confirmPassword];
}
