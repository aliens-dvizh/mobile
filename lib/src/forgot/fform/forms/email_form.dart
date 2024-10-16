import 'package:fform/fform.dart';

import '../../../auth/export.dart';

class EmailForm extends FForm {
  EmailField email;

  EmailForm({required this.email});

  factory EmailForm.parse({String? email}) => EmailForm(
        email: EmailField(value: email ?? ''),
      );

  change({String? email}) {
    this.email.value = email ?? '';
  }

  @override
  bool get allFieldUpdateCheck => false;

  @override
  List<FFormField> get fields => [email];
}
