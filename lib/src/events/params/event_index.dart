// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/params/params.dart';

class EventIndexParams with Params {
  EventIndexParams({
    this.page = 1,
    this.perPage = 10,
    this.endAt,
    this.startAt,
    this.categoryId,
  });

  final int page;
  final int perPage;
  final DateTime? startAt;
  final DateTime? endAt;
  final int? categoryId;

  @override
  Map<String, Object?> toMap() => {};

  EventIndexParams copyWith({
    int? page,
    int? perPage,
    DateTime? startAt,
    DateTime? endAt,
    int? categoryId,
  }) => EventIndexParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      categoryId: categoryId ?? this.categoryId,
    );
}

