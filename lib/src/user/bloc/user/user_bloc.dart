// 📦 Package imports:
import 'dart:async';

import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/export.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';
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
        },
    );

    _initialize();
  }

  final IUserRepository _repository;
  final IAuthRepository _authRepository;
  late StreamSubscription<UserModel> _subscription;
  late StreamSubscription<AuthModel?> _authSubscription;


  Future<void> _initialize() async {
    _authSubscription = _authRepository.on(_listenAuth);
    _subscription = _repository.stream.listen(_listenUser);
    _listenAuth(await _authRepository.auth);
  }

  void _listenAuth(AuthModel? auth) {
    if (auth == null) return add(_UserClearEvent());
    add(UserFetchEvent());
  }

  void _listenUser(UserModel user) => add(_UserChangeEvent(user));

  void _change(_UserChangeEvent event, Emitter<UserState> emit) {
    if(state is! UserLoadedState) return;
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

  @override
  Future<void> close() {
    _subscription.cancel();
    _authSubscription.cancel();
    return super.close();
  }
}
