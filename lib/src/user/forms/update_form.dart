import 'package:dvizh_mob/src/auth/export.dart';
import 'package:fform/fform.dart';

class UpdateUserForm extends FForm {
  UpdateUserForm({required this.name}) : super(fields: [name]);

  factory UpdateUserForm.notFilled() => UpdateUserForm(name: NameField(value: ''));

  final NameField name;


}