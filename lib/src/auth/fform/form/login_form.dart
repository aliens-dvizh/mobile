// 📦 Package imports:

// 📦 Package imports:
import 'package:fform/fform.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/fform/fields/export.dart';

class LoginForm extends FForm {
  LoginForm({required this.email, required this.password})
      : super(fields: [email, password]);

  factory LoginForm.parse({String email = '', String password = ''}) =>
      LoginForm(
        email: EmailField(value: email),
        password: PasswordField(value: password),
      );
  EmailField email;
  PasswordField password;

  void change({String? email, String? password}) {
    this.email.value = email ?? '';
    this.password.value = password ?? '';
  }
}
