// 🌎 Project imports:
import 'package:dvizh_mob/core/models/model/model.dart';

class ListDataModel<T extends ModelItem> {
  ListDataModel({required this.list, this.count = 0});

  List<T> list;
  int count;

  ListDataModel<T> copyWith({
    List<T>? list,
    int? count,
  }) =>
      ListDataModel<T>(
        list: list ?? this.list,
        count: count ?? this.count,
      );
}
