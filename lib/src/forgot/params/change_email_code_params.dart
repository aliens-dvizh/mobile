import '../../../core/models/params/params.dart';

class CodeToChangeEmailParams extends Params {
  final String password;

  CodeToChangeEmailParams({required this.password});

  @override
  Map<String, String> toMap() {
    return {'password': password};
  }
}
