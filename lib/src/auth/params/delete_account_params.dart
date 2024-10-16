import '../../../core/models/params/params.dart';

class DeleteAccountParams extends Params {
  final int code;

  DeleteAccountParams({
    required this.code,
  });
  @override
  toData() {
    return {'code': code};
  }
}
