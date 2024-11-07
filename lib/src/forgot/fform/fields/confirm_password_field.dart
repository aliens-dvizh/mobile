// 📦 Package imports:
import 'package:fform/fform.dart';

enum ConfirmPasswordException {
  passwordsDoNotMatch;
}

class ConfirmPasswordField
    extends FFormField<String, ConfirmPasswordException> {
  ConfirmPasswordField({
    required String value,
    required this.password,
  }) : super(value);
  String password;

  @override
  ConfirmPasswordException? validator(String value) {
    if (value != password) return ConfirmPasswordException.passwordsDoNotMatch;
    return null;
  }
}
