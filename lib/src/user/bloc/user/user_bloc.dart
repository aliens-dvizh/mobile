// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/export.dart';
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository, this._authRepository) : super(UserInitialState()) {
    on<UserEvent>((event, emit) => switch (event) {
          UserFetchEvent() => _fetch(event, emit),
          _UserClearEvent() => _clear(event, emit),
          _UserChangeEvent() => _change(event, emit),
        });

    _authRepository.on(_listenAuth);
    _repository.stream.listen(_listenUser);
  }

  final IUserRepository _repository;
  final IAuthRepository _authRepository;

  void _listenAuth(AuthModel? auth) {
    if (auth == null) return add(_UserClearEvent());
    add(UserFetchEvent());
  }

  void _listenUser(UserModel user) => add(_UserChangeEvent(user));

  void _change(_UserChangeEvent event, Emitter<UserState> emit) {
    emit(UserLoadedState(user: event.user));
  }

  void _clear(_UserClearEvent event, Emitter<UserState> emit) {
    emit(UserInitialState());
  }

  Future<void> _fetch(UserFetchEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final result = await _repository.get();
      emit(UserLoadedState(user: result));
    } on Exception {
      emit(UserExceptionState());
    }
  }
}
