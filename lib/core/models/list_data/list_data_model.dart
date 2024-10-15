import '../model/model.dart';
import 'list_data_dto.dart';

class ListDataModel<T extends ModelItem> {
  List<T> list;
  int count;

  ListDataModel({required this.list, this.count = 0});

  factory ListDataModel.fromDTOList(ListDataDTO dto) {
    return dto.toModel<T>();
  }

  ListDataModel<T> copyWith({
    List<T>? list,
    int? count,
  }) {
    return ListDataModel<T>(
      list: list ?? this.list,
      count: count ?? this.count,
    );
  }
}
