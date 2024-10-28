import 'package:fform/fform.dart';

import '../../../auth/export.dart';

class EmailForm extends FForm {
  EmailField email;

  EmailForm({required this.email}) : super(fields: [email]);

  factory EmailForm.parse({String? email}) => EmailForm(
        email: EmailField(value: email ?? ''),
      );

  void change({String? email}) {
    this.email.value = email ?? '';
  }
}
