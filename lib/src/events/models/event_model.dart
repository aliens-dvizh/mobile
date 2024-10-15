import 'package:dvizh_mob/core/models/model/model.dart';

class EventModel extends ModelItem {
  final int id;
  final String name;
  final String description;

  EventModel({required this.id, required this.name, required this.description});
}
