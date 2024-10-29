// 📦 Package imports:
import 'package:fform/fform.dart';

// 🌎 Project imports:
import '../fields/export.dart';

class RegisterForm extends FForm {
  NameField name;
  EmailField email;
  PasswordField password;

  RegisterForm({
    required this.name,
    required this.email,
    required this.password,
  }) : super(fields: [name, email, password]);

  factory RegisterForm.parse({
    String? email,
    String? name,
    String? password,
  }) {
    return RegisterForm(
      name: NameField(value: name ?? ''),
      email: EmailField(value: email ?? ''),
      password: PasswordField(value: password ?? ''),
    );
  }

  void change({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? passwordConfirmation,
  }) {
    this.name.value = name ?? '';
    this.email.value = email ?? '';
    this.password.value = password ?? '';
  }
}
