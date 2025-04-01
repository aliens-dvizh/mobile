import 'package:dvizh_mob/src/core/models/model/dto.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';

class TicketDto with DTO<TicketModel> {
  TicketDto({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.status,
    required this.event,
  });

  factory TicketDto.fromJson(Map<String, Object?> value) => TicketDto(
      id: value['id'] as int,
      userId: value['user_id'] as String,
      eventId: value['event_id'] as int,
      event: EventDTO.fromJsonOrNull(value['event'] as Map<String, Object?>?),
      status: TicketStatus.fromJson(value['status'] as String),
    );

  final int id;
  final String userId;
  final int eventId;
  final TicketStatus status;
  final EventDTO? event;

  @override
  TicketModel toModel() => TicketModel(
      id: id,
      userId: userId,
      eventId: eventId,
      status: status,
      event: event?.toModel(),
    );
}
