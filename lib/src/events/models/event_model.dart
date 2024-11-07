// 🌎 Project imports:
import 'package:dvizh_mob/core/models/model/model.dart';

class EventModel with ModelItem {
  EventModel({required this.id, required this.name, required this.description});

  final int id;
  final String name;
  final String description;
}
