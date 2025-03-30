import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/favorite/data/favorite_repository.dart';
import 'package:talker/talker.dart';

part 'favorite_events_state.dart';

class FavoriteEventsCubit extends Cubit<FavoriteEventsState> {
  FavoriteEventsCubit(this._repository) : super(FavoriteEventsInitialState()) {
    fetch();
  }

  final FavoriteRepository _repository;

  Future<void> fetch() async {
    emit(FavoriteEventsLoadingState());
    try {
      final result = await _repository.get();

      emit(FavoriteEventsLoadedState(events: result));
    } on Exception catch (err) {
      emit(FavoriteEventsExceptionState());
    }
  }

  Future<void> add(int eventId) async {
    try {
      final result = await _repository.add(eventId);
      return switch (state) {
        FavoriteEventsInitialState() ||
        FavoriteEventsLoadingState() ||
        FavoriteEventsExceptionState() =>
          emit(
            FavoriteEventsLoadedState(
              events: [
                result,
              ],
            ),
          ),
        FavoriteEventsLoadedState state => emit(
            FavoriteEventsLoadedState(
              events: [
                result,
                ...state.events,
              ],
            ),
          ),
      };
    } on Exception catch (err) {
      print(err);
    }
  }

  Future<void> remove(int eventId) async {
    try {
      await _repository.remove(eventId);
      return switch (state) {
        FavoriteEventsInitialState() ||
        FavoriteEventsLoadingState() ||
        FavoriteEventsExceptionState() =>
            emit(
              FavoriteEventsLoadedState(
                events: [],
              ),
            ),
        FavoriteEventsLoadedState state => emit(
          FavoriteEventsLoadedState(
            events: state.events.where((event) => event.id != eventId).toList(),
          ),
        ),
      };
    } on Exception catch (err) {
      print(err);
    }
  }

  Future<void> toggle(int eventId) async {
    if(state case FavoriteEventsLoadedState state) {
      if(state.events.firstWhereOrNull((event) => event.id == eventId) == null) {
        return add(eventId);
      }
    }
    return remove(eventId);

  }

}
