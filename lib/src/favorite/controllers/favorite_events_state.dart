part of 'favorite_events_cubit.dart';

sealed class FavoriteEventsState {}

final class FavoriteEventsInitialState extends FavoriteEventsState {}

final class FavoriteEventsLoadingState extends FavoriteEventsState {}

final class FavoriteEventsLoadedState extends FavoriteEventsState {
  FavoriteEventsLoadedState({
    required this.events,
  });

  final List<EventModel> events;
}

final class FavoriteEventsExceptionState extends FavoriteEventsState {}
