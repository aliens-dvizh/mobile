// 📦 Package imports:

// 📦 Package imports:
import 'package:fform/fform.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/export.dart';
import 'package:dvizh_mob/src/forgot/fform/fields/export.dart';

class ConfirmPasswordForm extends FForm {
  ConfirmPasswordForm({required this.password, required this.confirmPassword})
      : super(fields: [password, confirmPassword]);

  factory ConfirmPasswordForm.parse({
    required String? password,
    required String? confirmPassword,
  }) =>
      ConfirmPasswordForm(
        password: PasswordField(value: password ?? ''),
        confirmPassword: ConfirmPasswordField(
          value: confirmPassword ?? '',
          password: password ?? '',
        ),
      );
  PasswordField password;
  ConfirmPasswordField confirmPassword;

  void change({
    String? password,
    String? confirmPassword,
  }) {
    var passwordValue = password ?? '';

    this.password.value = passwordValue;
    this.confirmPassword
      ..password = passwordValue
      ..value = confirmPassword ?? '';
  }
}
