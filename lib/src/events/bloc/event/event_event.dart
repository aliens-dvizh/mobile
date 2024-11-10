part of 'event_bloc.dart';

sealed class EventEvent {}

final class EventFetchEvent extends EventEvent {
  EventFetchEvent(this.id);

  final int id;
}
