// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/params/login_params_with_email.dart';
import 'package:dvizh_mob/src/auth/params/login_params_with_phone.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LoginSubmitted>(_login);
  }
  final IAuthRepository _authRepository;

  Future<void> _login(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state is LoginLoading) return;
    emit(LoginLoading());
    try {
      await _authRepository.loginWithPhone(event.params);

      emit(LoginSuccess());
    } on DioException catch (err) {
      final statusCode = err.response?.statusCode;
      if (statusCode == HttpStatus.badRequest) {
        return emit(LoginError('Ошибка'));
      }
      if (statusCode == HttpStatus.notAcceptable) {
        return emit(LoginRedirectVerifyState(email: event.params.phone));
      }
      if (statusCode == HttpStatus.unprocessableEntity) {
        return emit(LoginError('Неверный логин или пароль'));
      }
      return emit(LoginError('Ошибка'));
    } on Exception {
      return emit(LoginError('Ошибка'));
    }
  }
}
