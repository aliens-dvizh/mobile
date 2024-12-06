// 📦 Package imports:
import 'dart:async';

import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(AuthIsNotSign()) {
    on<AuthLogin>(_login);
    on<AuthLogout>(_logout);
    on<Unauthenticated>((event, emit) => emit(AuthIsNotSign()));
    _subscription = _repository.on(_listenerAuth);
    _initialize();
  }

  final IAuthRepository _repository;
  late final StreamSubscription<AuthModel?> _subscription;

  Future<void> _initialize() async {
    var auth = await _repository.auth;
    _listenerAuth(auth);
  }

  void _listenerAuth(AuthModel? auth) => switch(auth) {
      AuthModel() => add(AuthLogin()),
      null => add(Unauthenticated()),
    };

  void _login(AuthLogin event, Emitter<AuthState> emit) {
    emit(AuthIsSign());
  }

  Future<void> _logout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      await _repository.logout();
      add(Unauthenticated());
    } on Exception {
      add(Unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
