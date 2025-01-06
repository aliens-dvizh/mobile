// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/data/icategory_repository.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/current_location/data/repositories/current_location_repository.dart';

part 'city_from_ip_event.dart';
part 'city_from_ip_state.dart';

class CityFromIPBloc extends Bloc<CityFromIPEvent, CityFromIPState> {
  CityFromIPBloc(this._currentLocationRepository) : super(CityFromIPInitialState()) {
    on<CityFromIPEvent>(
      (event, emit) => switch (event) {
        CityFromIPFetchEvent() => _fetch(event, emit),
      },
    );
  }

  final ICurrentLocationRepository _currentLocationRepository;

  Future<void> _fetch(
    CityFromIPFetchEvent event,
    Emitter<CityFromIPState> emit,
  ) async {
    emit(CityFromIPLoadingState());
    try {
      final result = await _currentLocationRepository.getCityByIP();
      emit(CityFromIPLoadedState(city: result));
    } on Exception {
      emit(CityFromIPExceptionState());
    }
  }
}
