// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';
import 'package:dvizh_mob/src/auth/params/delete_account_params.dart';
import 'package:dvizh_mob/src/auth/params/login_params.dart';
import 'package:dvizh_mob/src/auth/params/register_params.dart';
import 'package:dvizh_mob/src/auth/params/verify_params.dart';
import 'package:event_truck/event_truck.dart';

final AuthModel _mock = AuthModel(token: 'token', refreshToken: 'refreshToken');

class MockAuthRepository extends IAuthRepository {
  MockAuthRepository() : _streamController = EventTruck<AuthModel?>();

  final EventTruck<AuthModel?> _streamController;
  AuthModel? _authModel;

  @override
  Future<AuthModel?> get auth async => _authModel;

  void setAuth(AuthModel? value) {
    _authModel = value;
    _streamController.add(_authModel);
  }

  StreamSubscription<AuthModel?> on(void Function(AuthModel?) callback) => _streamController.on<AuthModel?>(callback);

  @override
  Future<void> deleteAccount(DeleteAccountParams params) async {
    setAuth(null);
  }

  @override
  Future<void> login(LoginParams params) async {
    setAuth(_mock);
  }

  @override
  Future<void> logout() async {
    setAuth(null);
  }

  @override
  Future<AuthModel> refreshToken(AuthModel auth) async {
    setAuth(_mock);
    return auth;
  }

  @override
  Future<void> register(RegisterParams params) async {}

  @override
  Future<void> verify(VerifyParams params) async {
    setAuth(_mock);
  }

  @override
  void dispose() {
    _streamController.dispose();
  }
}
