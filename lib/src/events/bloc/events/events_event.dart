part of 'events_bloc.dart';

sealed class EventsEvent {}

class FetchEventsEvent extends EventsEvent {
  FetchEventsEvent({required this.params});
  final EventIndexParams params;
}
