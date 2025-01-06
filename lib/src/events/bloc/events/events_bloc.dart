// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/models/event_model.dart';
import 'package:dvizh_mob/src/events/params/event_index.dart';
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';

part 'events_event.dart';

part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc(this._eventRepository) : super(EventsInitial()) {
    on<EventsEvent>(
      (event, emit) => switch (event) {
        FetchEventsEvent() => _fetch(event, emit),
      },
    );
  }

  final IEventRepository _eventRepository;

  Future<void> _fetch(FetchEventsEvent event, Emitter<EventsState> emit) async {
    emit(EventsLoading());
    try {
      final result = await _eventRepository.getEvents(event.params);

      emit(EventsLoaded(events: result));
    } on Exception {
      emit(EventsError());
    }
  }
}
