part of 'events_bloc.dart';

sealed class EventsState {}

final class EventsInitial extends EventsState {}

final class EventsLoading extends EventsState {}

final class EventsLoaded extends EventsState {
  EventsLoaded({required this.events});

  final ListDataModel<EventModel> events;
}

final class EventsError extends EventsState {}
