// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class CodeToChangeEmailParams with Params {
  CodeToChangeEmailParams({required this.password});

  final String password;

  @override
  Map<String, dynamic> toMap() => {'password': password};
}
