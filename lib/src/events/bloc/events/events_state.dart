part of 'events_bloc.dart';

sealed class EventsState {}

final class EventsInitial extends EventsState {}

final class EventsLoading extends EventsState {}

final class EventsLoaded extends EventsState {
  final List events;

  EventsLoaded({required this.events});
}

final class EventsError extends EventsState {}
