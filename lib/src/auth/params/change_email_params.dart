// 🌎 Project imports:
import '../../../core/models/params/params.dart';

class ChangeEmailParams extends Params {
  final String newEmail;
  final int code;

  ChangeEmailParams({
    required this.newEmail,
    required this.code,
  });
  @override
  Map<String, Object> toMap() {
    return {'email': newEmail, 'code': code};
  }
}
