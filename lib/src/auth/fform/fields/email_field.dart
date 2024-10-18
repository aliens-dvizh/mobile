import 'package:fform/fform.dart';

enum EmailError {
  empty,
  invalid,
}

class EmailField extends FFormField<String, EmailError> {
  EmailField({String value = ''}) : super(value);

  @override
  EmailError? validator(value) {
    if (value.isEmpty) return EmailError.empty;
    return null;
  }
}
