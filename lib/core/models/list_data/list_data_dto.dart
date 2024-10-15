import '../model/dto.dart';
import '../model/model.dart';
import 'list_data_model.dart';

class ListDataDTO<T extends DTO> {
  List<T> list;
  int count;

  ListDataDTO({required this.list, this.count = 0});

  factory ListDataDTO.fromJson(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ListDataDTO<T>(
      list: (json[key] as List).map((item) => fromJsonT(item)).toList(),
      count: json['count'] ?? 0,
    );
  }

  factory ListDataDTO.fromList(List<T> list, int count) {
    return ListDataDTO<T>(list: list, count: count);
  }

  factory ListDataDTO.empty() {
    return ListDataDTO<T>(list: [], count: 0);
  }

  ListDataModel<M> toModel<M extends ModelItem>() {
    return ListDataModel(
        list: list.map((e) => e.toModel() as M).toList(), count: count);
  }
}
