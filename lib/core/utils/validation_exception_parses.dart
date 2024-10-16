import 'package:fform/fform.dart';

class ValidationExceptionParser {
  static String? getFieldException(FFormField field) {
    if (field.isValid) return null;
    return field.exception.toString();
  }
}
