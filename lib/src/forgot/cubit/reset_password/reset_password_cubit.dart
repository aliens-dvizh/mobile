import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../params/reset_password_params.dart';
import '../../repository/forgot_repository.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ForgotRepository _userRepository;

  ResetPasswordCubit(this._userRepository) : super(ResetPasswordInitial());

  Future reset(ResetPasswordParams params) async {
    if (state is ResetPasswordLoading) return;

    emit(ResetPasswordLoading());
    try {
      await _userRepository.resetPassword(params);
      emit(ResetPasswordSuccess());
    } on DioException {
      emit(ResetPasswordError('Ошибка'));
    } catch (err) {
      emit(ResetPasswordError('Ошибка'));
    }
  }
}
