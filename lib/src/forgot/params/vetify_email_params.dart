import '../../../core/models/params/params.dart';

class VerifyEmailParams extends Params {
  final String email;
  final int code;

  VerifyEmailParams({
    required this.email,
    required this.code,
  });

  @override
  Map<String, Object> toMap() {
    final data = {
      'email': email,
      'code': code,
    };
    return data;
  }
}
