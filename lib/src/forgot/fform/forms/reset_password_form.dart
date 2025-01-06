// 📦 Package imports:

// 📦 Package imports:
import 'package:dvizh_mob/src/auth/fform/export.dart';
import 'package:fform/fform.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/export.dart';

class ResetForm extends FForm {
  ResetForm({required this.email, required this.password})
      : super(fields: [email, password]);

  factory ResetForm.parse({
    required String email,
    required String password,
  }) =>
      ResetForm(
        email: EmailField(value: email),
        password: PasswordField(value: password),
      );

  final EmailField email;
  final PasswordField password;
}
