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
  final bool isRequired;

  NameField({
    required String value,
    this.isRequired = true,
  }) : super(value);

  @override
  NameError? validator(value) {
    if (isRequired) {
      if (value.isEmpty) return NameError.empty;
    }
    return null;
  }
}
