// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/model/dto.dart';
import 'package:dvizh_mob/src/events/models/event_model.dart';

class EventDTO with DTO<EventModel> {
  EventDTO({
    required this.id,
    required this.name,
    this.description,
    this.image,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) => EventDTO(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String?,
        image: json['image'] as String?,
      );

  final int id;
  final String name;
  final String? description;
  final String? image;

  @override
  EventModel toModel() => EventModel(
        id: id,
        name: name,
        description: description,
        image: image,
      );
}
