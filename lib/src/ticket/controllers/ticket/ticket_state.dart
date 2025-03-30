part of 'ticket_cubit.dart';

sealed class TicketState {}

final class TicketInitialState extends TicketState {}

final class TicketLoadedState extends TicketState {
  TicketLoadedState({required this.ticket});

  final TicketModel ticket;
}

final class TicketLoadingState extends TicketState {}

final class TicketExceptionState extends TicketState {}
