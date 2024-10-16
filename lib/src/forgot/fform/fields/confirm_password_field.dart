import 'package:fform/fform.dart';

enum ConfirmPasswordException {
  passwordsDoNotMatch;
}

class ConfirmPasswordField
    extends FFormField<String, ConfirmPasswordException> {
  String password;

  ConfirmPasswordField({
    required String value,
    required this.password,
  }) : super(value);

  @override
  ConfirmPasswordException? validator(String value) {
    if (value != password) return ConfirmPasswordException.passwordsDoNotMatch;
    return null;
  }
}
