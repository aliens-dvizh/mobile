// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class EventIndexParams with Params {
  EventIndexParams({this.page = 1, this.perPage = 10});
  final int page;
  final int perPage;
  final DateTime startAt = DateTime.now();

  @override
  Map<String, Object?> toMap() => {
        'page': page,
        'per_page': perPage,
        'start_at': startAt.toString(),
      };
}
