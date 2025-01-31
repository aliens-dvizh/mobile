import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_logout_event.dart';
part 'auth_logout_state.dart';

class AuthLogoutBloc extends Bloc<AuthLogoutEvent, AuthLogoutState> {
  AuthLogoutBloc(this._authRepository) : super(AuthLogoutInitial()) {
    on<AuthLogoutEvent>((event, emit) => switch(event) {
      AuthLogoutFetchEvent() => _logout(event, emit),
    });
  }


  final IAuthRepository _authRepository;

  Future<void> _logout(
      AuthLogoutEvent event,
      Emitter<AuthLogoutState> emit,
      ) async {
    if (state is AuthLogoutLoading) return;
    emit(AuthLogoutLoading());

    try {
      await _authRepository.logout();
      emit(AuthLogoutSuccess());
    }  on Exception {
      emit(AuthLogoutError(error: 'Ошибка'));
    }
  }
}
