import '../../../core/models/params/params.dart';

class VerifyParams extends Params {
  final String email;
  final String code;

  VerifyParams({
    required this.email,
    required this.code,
  });

  @override
  toData() {
    return {
      'email': email,
      'code': code,
    };
  }
}
