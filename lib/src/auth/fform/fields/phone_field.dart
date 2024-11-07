// 📦 Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fform/fform.dart';

enum PhoneError {
  empty,
  not;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'phoneEmpty'.tr();
      case not:
        return 'invalidFormatPhone'.tr();

      default:
        return 'invalidFormatPhone'.tr();
    }
  }
}

class PhoneField extends FFormField<String, PhoneError> {
  PhoneField({
    required String value,
    this.isRequired = true,
  }) : super(value);
  final bool isRequired;

  @override
  PhoneError? validator(value) {
    if (isRequired) {
      if (value.isEmpty) return PhoneError.empty;
    }
    return null;
  }
}
