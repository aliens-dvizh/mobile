// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class EventIndexParams with Params {
  EventIndexParams({
    this.page = 1,
    this.perPage = 10,
    this.endAt,
    this.startAt,
  });

  final int page;
  final int perPage;
  final DateTime? startAt;
  final DateTime? endAt;

  @override
  Map<String, Object?> toMap() => {};
}
