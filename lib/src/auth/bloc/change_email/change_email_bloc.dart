// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import '../../data/auth_repository.dart';
import '../../params/change_email_params.dart';

part 'change_email_events.dart';
part 'change_email_state.dart';

class ChangeEmailBloc extends Bloc<ChangeEmailEvent, ChangeEmailState> {
  final AuthRepository _authRepository;
  ChangeEmailBloc(this._authRepository) : super(ChangeEmailInitial()) {
    on<ChangeEmail>(_changeEmail);
  }

  Future<void> _changeEmail(
    ChangeEmail event,
    Emitter<ChangeEmailState> emit,
  ) async {
    if (state is ChangeEmailLoading) return;
    emit(ChangeEmailLoading());

    try {
      await _authRepository.changeEmail(event.params);
      emit(ChangeEmailSuccess());
    } on DioException {
      emit(ChangeEmailError(error: 'Ошибка'));
    } catch (error) {
      emit(ChangeEmailError(error: 'Ошибка'));
    }
  }
}
