// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/auth_repository.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(AuthIsNotSign()) {
    on<AuthLogin>(_login);
    on<AuthLogout>(_logout);
    on<Unauthenticated>((event, emit) => emit(AuthIsNotSign()));
    _initialize();
  }
  final AuthRepository _repository;

  Future<void> _initialize() async {
    var auth = await _repository.auth;
    _listenerAuth(auth);
    _repository.authStream.listen(_listenerAuth);
  }

  void _listenerAuth(AuthModel? auth) {
    if (auth != null) {
      add(AuthLogin());
    } else {
      add(Unauthenticated());
    }
  }

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
}
