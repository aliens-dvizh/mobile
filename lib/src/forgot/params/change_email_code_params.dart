import '../../../core/models/params/params.dart';

class CodeToChangeEmailParams extends Params {
  final String password;

  CodeToChangeEmailParams({required this.password});

  @override
  toData() {
    return {'password': password};
  }
}
