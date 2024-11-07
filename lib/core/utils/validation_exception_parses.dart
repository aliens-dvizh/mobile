// 📦 Package imports:
import 'package:fform/fform.dart';

mixin ValidationExceptionParser {
  String? getFieldException<T, E>(FForm fform, FFormField<T, E> field) {
    if (!fform.hasCheck) return null;
    if (field.isValid) return null;
    return field.exception.toString();
  }
}
