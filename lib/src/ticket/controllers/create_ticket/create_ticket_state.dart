part of 'create_ticket_cubit.dart';

sealed class CreateTicketState {}

final class CreateTicketInitialState extends CreateTicketState {}

final class CreateTicketLoadingState extends CreateTicketState {}

final class CreateTicketLoadedState extends CreateTicketState {
  CreateTicketLoadedState({required this.ticket});

  final TicketModel ticket;


}

final class CreateTicketExceptionState extends CreateTicketState {}



