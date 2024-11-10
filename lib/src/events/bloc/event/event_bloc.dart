// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/export.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc(this._eventRepository) : super(EventInitialState()) {
    on<EventEvent>(
      (event, emit) => switch (event) {
        EventFetchEvent() => _fetch(event, emit),
      },
    );
  }

  final EventRepository _eventRepository;

  Future<void> _fetch(EventFetchEvent event, Emitter<EventState> emit) async {
    emit(EventLoadingState());
    try {
      final result = await _eventRepository.getById(event.id);

      emit(EventLoadedState(event: result));
    } on Exception {
      emit(EventExceptionState());
    }
  }
}
