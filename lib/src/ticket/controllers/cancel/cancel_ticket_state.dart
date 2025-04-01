part of 'cancel_ticket_cubit.dart';

sealed class CancelTicketState {}

final class CancelTicketInitialState extends CancelTicketState {}

final class CancelTicketLoadingState extends CancelTicketState {}

final class CancelTicketLoadedState extends CancelTicketState {}

final class CancelTicketExceptionState extends CancelTicketState {}



