import 'package:fform/fform.dart';

class ValidationExceptionParser {
  static String? getFieldException(FForm fform, FFormField field) {
    if (!fform.hasCheck) return null;
    if (field.isValid) return null;
    return field.exception.toString();
  }
}
