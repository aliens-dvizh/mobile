// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/params/verify_params.dart';

part 'verify_state.dart';
part 'verify_event.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  VerifyBloc(this._authRepository) : super(VerifyInitial()) {
    on<VerifyFetch>(verify);
    on<ResendVerificationCode>(_resendVerificationCode);
  }
  final IAuthRepository _authRepository;

  Future<void> verify(VerifyFetch event, Emitter<VerifyState> emit) async {
    if (state is VerifyLoading) return;

    emit(VerifyLoading());
    try {
      await _authRepository.verify(event.params);
      emit(VerifySuccess());
    } on DioException {
      return emit(VerifyNetworkError());
    } on Exception {
      emit(VerifyError());
    }
  }

  Future<void> _resendVerificationCode(
    ResendVerificationCode event,
    Emitter<VerifyState> emit,
  ) async {}
}
