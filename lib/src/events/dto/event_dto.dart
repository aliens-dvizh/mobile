import 'package:dvizh_mob/core/models/model/dto.dart';
import 'package:dvizh_mob/src/events/models/event_model.dart';

class EventDTO extends DTO<EventModel> {
  final int id;
  final String name;
  final String description;

  EventDTO({required this.id, required this.name, required this.description});

  @override
  EventModel toModel() =>
      EventModel(id: id, name: name, description: description);

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    return EventDTO(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
