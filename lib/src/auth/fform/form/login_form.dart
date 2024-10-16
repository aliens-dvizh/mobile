import 'package:fform/fform.dart';

import '../fields/export.dart';

class LoginForm extends FForm {
  EmailField email;
  PasswordField password;

  LoginForm({required this.email, required this.password});

  factory LoginForm.parse({String email = '', String password = ''}) {
    return LoginForm(
      email: EmailField(value: email),
      password: PasswordField(value: password),
    );
  }

  change({String? email, String? password}) {
    this.email.value = email ?? '';
    this.password.value = password ?? '';
  }

  @override
  bool get allFieldUpdateCheck => true;

  @override
  List<FFormField> get fields => [email, password];
}
