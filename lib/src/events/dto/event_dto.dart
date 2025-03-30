// 🌎 Project imports:
import 'package:dvizh_mob/src/category/dto/category_dto.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/model/dto.dart';
import 'package:dvizh_mob/src/events/models/event_model.dart';

class EventDTO with DTO<EventModel> {
  EventDTO({
    required this.id,
    required this.name,
    this.description,
    this.holdedAt,
    this.images = const [],
    this.category,
    this.place,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) => EventDTO(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String?,
        images: (json['event_image'] as List<dynamic>?)
                ?.map((image) =>
                    ImageModel.fromJson(image as Map<String, dynamic>))
                .toList() ??
            [],
        holdedAt: DateTime.parse(json['holded_at'] as String? ?? ''),
        category: CategoryDTO.fromJsonOrNull(
                json['category'] as Map<String, Object?>?)
            ?.toModel(),

        place: PlaceModel.fromJsonOrNull(json['place'] as Map<String, dynamic>?)
      );

  static EventDTO? fromJsonOrNull(Map<String, dynamic>? json) => json == null ? null : EventDTO.fromJson(json);

  final int id;
  final String name;
  final String? description;
  final DateTime? holdedAt;
  final List<ImageModel> images;
  final CategoryModel? category;
  final PlaceModel? place;

  @override
  EventModel toModel() => EventModel(
        id: id,
        name: name,
        description: description,
        images: images,
        holdedAt: holdedAt,
        category: category,
    place: place,
      );
}

class ImageModel {
  ImageModel({required this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        url: json['url'] as String,
      );

  final String url;

  Map<String, dynamic> toJson() => {
        'url': url,
      };
}

class PlaceModel {
  PlaceModel({
    required this.lat,
    required this.lon,
    required this.name,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        lat: json['lat'] as double,
        lon: json['lon'] as double,
    name: json['name'] as String
       );

  static PlaceModel? fromJsonOrNull(Map<String, dynamic>? json) =>
      json == null ? null : PlaceModel.fromJson(json);

  final double lat;
  final double lon;
  final String name;

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
        'name': name,

      };
}
