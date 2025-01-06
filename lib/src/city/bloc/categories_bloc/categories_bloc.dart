// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/data/icategory_repository.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/city/data/icategory_repository.dart';
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  CitiesBloc(this._categoryRepository) : super(CitiesInitialState()) {
    on<CitiesEvent>(
      (event, emit) => switch (event) {
        CitiesFetchEvent() => _fetch(event, emit),
      },
    );
    add(CitiesFetchEvent());
  }

  final ICityRepository _categoryRepository;

  Future<void> _fetch(
    CitiesFetchEvent event,
    Emitter<CitiesState> emit,
  ) async {
    emit(CitiesLoadingState());
    try {
      final result = await _categoryRepository.getCityList();
      emit(CitiesLoadedState(categories: result));
    } on Exception {
      emit(CitiesExceptionState());
    }
  }
}
