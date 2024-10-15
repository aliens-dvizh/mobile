part of 'events_bloc.dart';

sealed class EventsEvent {}

class FetchEventsEvent extends EventsEvent {
  final EventIndexParams params;

  FetchEventsEvent({required this.params});
}
