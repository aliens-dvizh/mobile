// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

// 🌎 Project imports:
import '../../params/forgot_params.dart';
import '../../repository/forgot_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotRepository _userRepository;

  ForgotPasswordCubit(this._userRepository) : super(ForgotPasswordInitial());

  void setState() {
    emit(ForgotPasswordSuccess(email: ''));
  }

  Future forgot(ForgotParams params) async {
    if (state is ForgotPasswordLoading) return;

    emit(ForgotPasswordLoading());
    try {
      await _userRepository.forgotPassword(params);
      emit(ForgotPasswordSuccess(email: params.email));
    } on DioException {
      emit(ForgotPasswordError('Ошибка'));
    } catch (err) {
      emit(ForgotPasswordError('Ошибка'));
    }
  }
}
