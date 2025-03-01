// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/core/models/model/dto.dart';
import 'package:dvizh_mob/src/core/models/model/model.dart';

class ListDataDTO<T extends DTO<M>, M extends ModelItem> {
  ListDataDTO({required this.list, this.count = 0});

  factory ListDataDTO.fromJson(
    Map<String, Object?> json,
    String key,
    T Function(Map<String, Object?>) fromJsonT,
  ) =>
      ListDataDTO<T, M>(
        list: (json[key] as List<Object?>)
            .map((item) => fromJsonT(item as Map<String, Object?>))
            .toList(),
        count: json['count'] as int? ?? 0,
      );

  factory ListDataDTO.fromJsonList(
    List<Map<String, Object?>> json,
    T Function(Map<String, Object?>) fromJsonT,
  ) =>
      ListDataDTO<T, M>(
        list: json.map((item) => fromJsonT(item)).toList(),
        count: json.length,
      );

  factory ListDataDTO.fromList(List<T> list, int count) =>
      ListDataDTO<T, M>(list: list, count: count);

  factory ListDataDTO.empty() => ListDataDTO<T, M>(list: [], count: 0);

  List<T> list;

  int count;

  ListDataModel<M> toModel() => ListDataModel(
        list: list.map((e) => e.toModel()).toList(),
        count: count,
      );
}
