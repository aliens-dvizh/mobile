// 🌎 Project imports:
import 'package:dvizh_mob/core/models/params/params.dart';

class EventIndexParams with Params {
  EventIndexParams({this.page = 1, this.perPage = 10});
  final int page;
  final int perPage;

  @override
  Map<String, int> toMap() => {
        'page': page,
        'per_page': perPage,
      };
}
