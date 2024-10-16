import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../data/auth_repository.dart';
import '../../params/export.dart';

part 'registration_state.dart';
part 'registration_event.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _authRepository;

  RegistrationBloc(this._authRepository) : super(RegistrationInitial()) {
    on<Register>(_register);
  }

  Future<void> _register(
      Register event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());
    try {
      await _authRepository.register(event.params);
      emit(RegistrationSuccess(email: event.params.email));
    } on DioException {
      RegistrationFailure();
    } catch (err) {
      emit(RegistrationFailure());
    }
  }
}
