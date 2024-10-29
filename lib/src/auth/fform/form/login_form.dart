// 📦 Package imports:
import 'package:fform/fform.dart';

// 🌎 Project imports:
import '../fields/export.dart';

class LoginForm extends FForm {
  EmailField email;
  PasswordField password;

  LoginForm({required this.email, required this.password})
      : super(fields: [email, password]);

  factory LoginForm.parse({String email = '', String password = ''}) {
    return LoginForm(
      email: EmailField(value: email),
      password: PasswordField(value: password),
    );
  }

  void change({String? email, String? password}) {
    this.email.value = email ?? '';
    this.password.value = password ?? '';
  }
}
