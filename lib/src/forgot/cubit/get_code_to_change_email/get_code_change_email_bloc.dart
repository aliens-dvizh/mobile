import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../params/change_email_code_params.dart';
import '../../repository/forgot_repository.dart';

part 'get_code_change_email_events.dart';

part 'get_code_change_email_state.dart';

class GetCodeToChangeEmailBloc
    extends Bloc<ChangeEmailEvent, GetCodeToChangeEmailState> {
  final ForgotRepository _forgotRepository;

  GetCodeToChangeEmailBloc(this._forgotRepository)
      : super(GetCodeToChangeEmailInitial()) {
    on<GetCodeChangeEmail>(_changeEmail);
  }

  Future<void> _changeEmail(
    GetCodeChangeEmail event,
    Emitter<GetCodeToChangeEmailState> emit,
  ) async {
    if (state is GetCodeToChangeEmailLoading) return;
    emit(GetCodeToChangeEmailLoading());

    try {
      await _forgotRepository.getSendCodeToChangeEmail(event.params);
      emit(GetCodeToChangeEmailSuccess());
    } on DioException catch (error) {
      emit(GetCodeToChangeEmailError(error: 'Ошибка'));
    } catch (error) {
      emit(GetCodeToChangeEmailError(error: 'Ошибка'));
    }
  }
}
