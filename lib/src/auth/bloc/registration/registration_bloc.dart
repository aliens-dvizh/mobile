// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/params/register_params.dart';

part 'registration_state.dart';
part 'registration_event.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc(this._authRepository) : super(RegistrationInitial()) {
    on<Register>(_register);
  }
  final IAuthRepository _authRepository;

  Future<void> _register(
    Register event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());
    try {
      await _authRepository.register(event.params);
      emit(RegistrationSuccess(email: event.params.phone));
    } on DioException {
      emit(RegistrationFailure());
    } on Exception catch(err) {
      print(err);
      emit(RegistrationFailure());
    }
  }
}
