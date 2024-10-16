import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';
import '../../params/delete_account_params.dart';

part 'delete_account_event.dart';

part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final AuthRepository _authRepository;

  DeleteAccountBloc(this._authRepository) : super(DeleteAccountInitial()) {
    on<DeleteAccount>(_deleteAccount);
  }

  Future<void> _deleteAccount(
      DeleteAccount event, Emitter<DeleteAccountState> emit) async {
    if (state is DeleteAccountLoading) return;
    emit(DeleteAccountLoading());

    try {
      await _authRepository.deleteAccount(event.params);
      emit(DeleteAccountSuccess());
    } on DioException {
      emit(DeleteAccountError(error: 'Ошибка'));
    } catch (error) {
      emit(DeleteAccountError(error: 'Ошибка'));
    }
  }
}
