import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../data/auth_repository.dart';
import '../../params/export.dart';

part 'verify_state.dart';
part 'verify_event.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final AuthRepository _authRepository;

  VerifyBloc(this._authRepository) : super(VerifyInitial()) {
    on<VerifyFetch>(verify);
    on<ResendVerificationCode>(_resendVerificationCode);
  }

  Future verify(VerifyFetch event, Emitter<VerifyState> emit) async {
    if (state is VerifyLoading) return;

    emit(VerifyLoading());
    try {
      await _authRepository.verify(event.params);
      emit(VerifySuccess());
    } on DioException {
      return emit(VerifyNetworkError());
    } catch (err) {
      emit(VerifyError());
    }
  }

  Future _resendVerificationCode(
    ResendVerificationCode event,
    Emitter<VerifyState> emit,
  ) async {}
}
