// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/data/icategory_repository.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this._categoryRepository) : super(CategoriesInitialState()) {
    on<CategoriesEvent>(
      (event, emit) => switch (event) {
        CategoriesFetchEvent() => _fetch(event, emit),
      },
    );
  }

  final ICategoryRepository _categoryRepository;

  Future<void> _fetch(
    CategoriesFetchEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoadingState());
    try {
      final result = await _categoryRepository.getCategoryList();
      emit(CategoriesLoadedState(categories: result));
    } on Exception {
      emit(CategoriesExceptionState());
    }
  }
}
