import '../../../core/models/params/params.dart';

class VerifyParams extends Params {
  final String email;
  final String code;

  VerifyParams({
    required this.email,
    required this.code,
  });

  @override
  Map<String, String> toMap() {
    return {
      'email': email,
      'code': code,
    };
  }
}
