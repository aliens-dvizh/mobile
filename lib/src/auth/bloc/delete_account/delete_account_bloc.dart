// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/auth_repository.dart';
import 'package:dvizh_mob/src/auth/params/delete_account_params.dart';

part 'delete_account_event.dart';

part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc(this._authRepository) : super(DeleteAccountInitial()) {
    on<DeleteAccount>(_deleteAccount);
  }

  final IAuthRepository _authRepository;

  Future<void> _deleteAccount(
    DeleteAccount event,
    Emitter<DeleteAccountState> emit,
  ) async {
    if (state is DeleteAccountLoading) return;
    emit(DeleteAccountLoading());

    try {
      await _authRepository.deleteAccount(event.params);
      emit(DeleteAccountSuccess());
    } on DioException {
      emit(DeleteAccountError(error: 'Ошибка'));
    } on Exception {
      emit(DeleteAccountError(error: 'Ошибка'));
    }
  }
}
