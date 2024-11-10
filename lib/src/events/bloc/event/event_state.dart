part of 'event_bloc.dart';

sealed class EventState {}

final class EventInitialState extends EventState {}

final class EventLoadingState extends EventState {}

final class EventLoadedState extends EventState {
  EventLoadedState({required this.event});

  final EventModel event;
}

final class EventExceptionState extends EventState {}
