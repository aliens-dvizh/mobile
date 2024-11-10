// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class DeleteAccountParams with Params {
  DeleteAccountParams({
    required this.code,
  });

  final int code;

  @override
  Map<String, int> toMap() => {'code': code};
}
