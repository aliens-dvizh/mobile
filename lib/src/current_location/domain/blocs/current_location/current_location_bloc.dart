import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/current_location/data/repositories/current_location_repository.dart';
import 'package:meta/meta.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

class CurrentLocationBloc extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  CurrentLocationBloc(this._repository) : super(CurrentLocationInitial()) {
    on<CurrentLocationEvent>((event, emit) => switch(event) {
      SetCurrentLocationEvent() => _set(event, emit),
      GetCurrentLocationEvent() => _get(event, emit),
    });
  }

  final ICurrentLocationRepository _repository;

  void _set(SetCurrentLocationEvent event, Emitter<CurrentLocationState> emit) {
    emit(CurrentLocationExist(city: event.city));
  }

  Future<void> _get(GetCurrentLocationEvent event, Emitter<CurrentLocationState> emit) async {
    try {
      final result = await _repository.getCityFromStorage();
      if(result == null) return emit(CurrentLocationInitial());
      return emit(CurrentLocationExist(city: result));
    } on Exception catch(err) {
      emit(CurrentLocationInitial());
    }
  }
}
