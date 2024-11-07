// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/forgot/params/forgot_params.dart';
import 'package:dvizh_mob/src/forgot/repository/forgot_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._userRepository) : super(ForgotPasswordInitial());
  final ForgotRepository _userRepository;

  void setState() {
    emit(ForgotPasswordSuccess(email: ''));
  }

  Future<void> forgot(ForgotParams params) async {
    if (state is ForgotPasswordLoading) return;

    emit(ForgotPasswordLoading());
    try {
      await _userRepository.forgotPassword(params);
      emit(ForgotPasswordSuccess(email: params.email));
    } on DioException {
      emit(ForgotPasswordError('Ошибка'));
    } on Exception {
      emit(ForgotPasswordError('Ошибка'));
    }
  }
}
