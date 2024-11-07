// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/forgot/params/change_email_code_params.dart';
import 'package:dvizh_mob/src/forgot/repository/forgot_repository.dart';

part 'get_code_change_email_events.dart';
part 'get_code_change_email_state.dart';

class GetCodeToChangeEmailBloc
    extends Bloc<ChangeEmailEvent, GetCodeToChangeEmailState> {
  GetCodeToChangeEmailBloc(this._forgotRepository)
      : super(GetCodeToChangeEmailInitial()) {
    on<GetCodeChangeEmail>(_changeEmail);
  }
  final ForgotRepository _forgotRepository;

  Future<void> _changeEmail(
    GetCodeChangeEmail event,
    Emitter<GetCodeToChangeEmailState> emit,
  ) async {
    if (state is GetCodeToChangeEmailLoading) return;
    emit(GetCodeToChangeEmailLoading());

    try {
      await _forgotRepository.getSendCodeToChangeEmail(event.params);
      emit(GetCodeToChangeEmailSuccess());
    } on DioException {
      emit(GetCodeToChangeEmailError(error: 'Ошибка'));
    } on Exception {
      emit(GetCodeToChangeEmailError(error: 'Ошибка'));
    }
  }
}
