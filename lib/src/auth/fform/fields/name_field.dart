// 📦 Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fform/fform.dart';

enum NameError {
  empty;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'nameEmpty'.tr();
      default:
        return 'invalidFormatName'.tr();
    }
  }
}

class NameField extends FFormField<String, NameError> {
  NameField({
    required String value,
    this.isRequired = true,
  }) : super(value);
  final bool isRequired;

  @override
  NameError? validator(String value) {
    if (isRequired) {
      if (value.isEmpty) return NameError.empty;
    }
    return null;
  }
}
