// 📦 Package imports:

// 📦 Package imports:
import 'package:fform/fform.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/export.dart';

class EmailForm extends FForm {
  EmailForm({required this.email}) : super(fields: [email]);

  factory EmailForm.parse({String? email}) => EmailForm(
        email: EmailField(value: email ?? ''),
      );
  EmailField email;

  void change({String? email}) {
    this.email.value = email ?? '';
  }
}
