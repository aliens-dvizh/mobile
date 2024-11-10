// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/data/user_repository.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  UpdateUserBloc(this._repository) : super(UpdateUserInitialState()) {
    on<UpdateUserEvent>(_update);
  }

  final UserRepository _repository;

  Future<void> _update(
      UpdateUserEvent event, Emitter<UpdateUserState> emit) async {
    emit(UpdateUserLoadingState());
    try {
      await _repository.update();
      emit(UpdateUserLoadedState());
    } on Exception {
      emit(UpdateUserExceptionState());
    }
  }
}
