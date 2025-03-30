// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';

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

  final IEventRepository _eventRepository;

  Future<void> _fetch(EventFetchEvent event, Emitter<EventState> emit) async {
    if(state case EventLoadedState state) {
      if(state.event.id == event.id) return;
    }

    emit(EventLoadingState());
    try {
      final result = await _eventRepository.getById(event.id);

      emit(EventLoadedState(event: result));
    } on Exception {
      emit(EventExceptionState());
    }
  }
}
