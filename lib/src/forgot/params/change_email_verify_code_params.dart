import '../../../core/models/params/params.dart';

class ChangeEmailVerifyCode extends Params {
  final String code;

  ChangeEmailVerifyCode({
    required this.code,
  });

  @override
  Map<String, dynamic> toData() {
    return {
      'code': code,
    };
  }
}
