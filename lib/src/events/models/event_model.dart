// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/model.dart';

class EventModel with ModelItem {
  EventModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
  });

  final int id;
  final String name;
  final String? description;
  final String? image;
}
