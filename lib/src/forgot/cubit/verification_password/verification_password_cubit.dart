// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/forgot/params/vetify_email_params.dart';
import 'package:dvizh_mob/src/forgot/repository/forgot_repository.dart';

part 'verification_password_state.dart';

class VerificationPasswordCubit extends Cubit<VerificationPasswordState> {
  VerificationPasswordCubit(this._userRepository)
      : super(VerificationPasswordInitial());

  final ForgotRepository _userRepository;

  Future<void> sendVerificationCode(VerifyEmailParams params) async {
    emit(VerificationPasswordLoading());
    try {
      await _userRepository.verifyCode(params);
      emit(VerificationPasswordSuccess());
    } on DioException {
      emit(VerificationPasswordError('Ошибка'));
    } on Exception {
      emit(VerificationPasswordError('Ошибка'));
    }
  }
}
