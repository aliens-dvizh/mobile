import 'package:dvizh_mob/src/core/models/model/model.dart';
import 'package:dvizh_mob/src/events/export.dart';

class TicketModel with ModelItem {
  TicketModel({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.status,
    this.event,
  });

  final int id;
  final String userId;
  final int eventId;
  final EventModel? event;
  final TicketStatus status;

  String get qrcode => '$id$userId$eventId';

  TicketModel copyWith({
    int? id,
    String? userId,
    int? eventId,
    EventModel? event,
    TicketStatus? status,
  }) => TicketModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      event: event ?? this.event,
      status: status ?? this.status,
    );
}
enum TicketStatus {
  activated,
  canceled;

  static TicketStatus fromJson(String value) {
    switch (value) {
      case 'activated':
        return TicketStatus.activated;
      case 'canceled':
        return TicketStatus.canceled;
      default:
        return TicketStatus.activated;
    }
  }
}
