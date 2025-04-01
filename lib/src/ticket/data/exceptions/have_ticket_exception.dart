
class HaveTicketException implements Exception {
  HaveTicketException({required this.ticketId});

  final int ticketId;
}
