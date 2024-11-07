// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/forgot/params/reset_password_params.dart';
import 'package:dvizh_mob/src/forgot/repository/forgot_repository.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._userRepository) : super(ResetPasswordInitial());
  final ForgotRepository _userRepository;

  Future<void> reset(ResetPasswordParams params) async {
    if (state is ResetPasswordLoading) return;

    emit(ResetPasswordLoading());
    try {
      await _userRepository.resetPassword(params);
      emit(ResetPasswordSuccess());
    } on DioException {
      emit(ResetPasswordError('Ошибка'));
    } on Exception {
      emit(ResetPasswordError('Ошибка'));
    }
  }
}
