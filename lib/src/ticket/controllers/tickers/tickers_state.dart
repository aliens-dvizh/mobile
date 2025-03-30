part of 'tickers_cubit.dart';

sealed class TicketsState {}

final class TickersInitialState extends TicketsState {}

final class TickersLoadingState extends TicketsState {}

final class TickersLoadedState extends TicketsState {
  TickersLoadedState({required this.tickets});

  final List<TicketModel> tickets;

}

final class TickersExceptionState extends TicketsState {}

