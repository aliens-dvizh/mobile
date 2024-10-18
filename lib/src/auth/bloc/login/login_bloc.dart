import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../data/auth_repository.dart';
import '../../params/export.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LoginSubmitted>(_login);
  }

  Future<void> _login(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state is LoginLoading) return;
    emit(LoginLoading());
    try {
      await _authRepository.login(event.params);
      emit(LoginSuccess());
    } on DioException catch (err) {
      final statusCode = err.response?.statusCode;
      if (statusCode == HttpStatus.badRequest) {
        return emit(LoginError('Ошибка'));
      }
      if (statusCode == HttpStatus.notAcceptable) {
        return emit(LoginRedirectVerifyState(email: event.params.email));
      }
      if (statusCode == HttpStatus.unprocessableEntity) {
        return emit(LoginError('Неверный логин или пароль'));
      }
      return emit(LoginError('Ошибка'));
    } catch (err) {
      return emit(LoginError('Ошибка'));
    }
  }
}
