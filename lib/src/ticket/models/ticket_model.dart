import 'package:dvizh_mob/src/events/export.dart';

class TicketModel {
  TicketModel({
    required this.id,
    required this.userId,
    required this.eventId,
    this.event,
  });

  final int id;
  final String userId;
  final int eventId;
  final EventModel? event;

  String get qrcode => '$id$userId$eventId';
}
