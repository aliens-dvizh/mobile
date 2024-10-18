import 'package:fform/fform.dart';

enum PasswordException {
  empty,
  min,
}

class PasswordField extends FFormField<String, PasswordException> {
  PasswordField({String value = ''}) : super(value);

  @override
  PasswordException? validator(String value) {
    if (value.isEmpty) return PasswordException.empty;
    if (value.length < 7) return PasswordException.min;
    return null;
  }
}
