// 🌎 Project imports:
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/model/model.dart';
import 'package:dvizh_mob/src/events/dto/event_dto.dart';

class EventModel with ModelItem {
  EventModel( {
    required this.id,
    required this.name,
    this.description,
    this.images = const [],
    this.holdedAt,
    this.category,
    this.place,
  });

  final int id;
  final String name;
  final String? description;
  final DateTime? holdedAt;
  final List<ImageModel> images;
  final CategoryModel? category;
  final PlaceModel? place;
}
