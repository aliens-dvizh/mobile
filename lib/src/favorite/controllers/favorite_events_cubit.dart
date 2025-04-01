import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/favorite/data/favorite_repository.dart';
import 'package:collection/collection.dart';
import 'package:throttling/throttling.dart';

part 'favorite_events_state.dart';

class FavoriteEventsCubit extends Cubit<FavoriteEventsState> {
  FavoriteEventsCubit(this._repository) : super(FavoriteEventsInitialState()) {
    fetch();
  }

  final FavoriteRepository _repository;
  final debouncer = Debouncing<void>(duration: const Duration(milliseconds: 1000));

  Future<void> fetch() async {
    emit(FavoriteEventsLoadingState());
    try {
      final result = await _repository.get();
      emit(FavoriteEventsLoadedState(events: result));
    } catch (err) {
      emit(FavoriteEventsExceptionState());
    }
  }

  void add(EventModel event) {
    if (state case FavoriteEventsLoadedState state) {
      emit(FavoriteEventsLoadedState(events: [event, ...state.events]));
    } else {
      emit(FavoriteEventsLoadedState(events: [event]));
    }

    debouncer.debounce(() => _repository.add(event.id));
  }

  void remove(int eventId) {
    if (state case FavoriteEventsLoadedState state) {
      emit(FavoriteEventsLoadedState(
        events: state.events.where((event) => event.id != eventId).toList(),
      ));
    } else {
      emit(FavoriteEventsLoadedState(events: []));
    }

    debouncer.debounce(() => _repository.remove(eventId));
  }

  void toggle(EventModel event) {
    if (state case FavoriteEventsLoadedState state) {
      final exists = state.events.firstWhereOrNull((e) => e.id == event.id) != null;
      exists ? remove(event.id) : add(event);
    }
  }

  @override
  Future<void> close() {
    debouncer.close();
    return super.close();
  }
}
