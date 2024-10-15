import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/models/event_model.dart';
import '../../params/event_index.dart';
import '../../repositories/event_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository _eventRepository;

  EventsBloc(this._eventRepository) : super(EventsInitial()) {
    on<FetchEventsEvent>(_fetch);
  }

  _fetch(FetchEventsEvent event, Emitter<EventsState> emit) async {
    emit(EventsLoading());
    try {
      final result = await _eventRepository.getEvents(event.params);

      emit(EventsLoaded(events: result));
    } catch (e) {
      emit(EventsError());
    }
  }
}
