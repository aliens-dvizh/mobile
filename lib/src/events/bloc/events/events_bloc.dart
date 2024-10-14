import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/event_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository _eventRepository;

  EventsBloc(this._eventRepository) : super(EventsInitial()) {
    on<FetchEventsEvent>((event, emit) async {
      emit(EventsLoading());
      try {
        final result = await _eventRepository.getEvents();

        emit(EventsLoaded(events: result));
      } catch (e) {
        emit(EventsError());
      }
    });
  }
}
