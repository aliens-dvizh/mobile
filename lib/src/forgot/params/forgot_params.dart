import '../../../core/models/params/params.dart';

class ForgotParams extends Params {
  final String email;

  ForgotParams({
    required this.email,
  });

  @override
  toData() {
    return {
      'email': email,
    };
  }
}
