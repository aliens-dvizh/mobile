// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';
import 'package:dvizh_mob/src/auth/params/delete_account_params.dart';
import 'package:dvizh_mob/src/auth/params/login_params.dart';
import 'package:dvizh_mob/src/auth/params/register_params.dart';
import 'package:dvizh_mob/src/auth/params/verify_params.dart';

final AuthModel _mock = AuthModel(token: 'token', refreshToken: 'refreshToken');

class MockAuthRepository extends IAuthRepository {
  MockAuthRepository() : _streamController = StreamController.broadcast();

  final StreamController<AuthModel?> _streamController;
  AuthModel? _authModel;

  @override
  Future<AuthModel?> get auth async => _authModel;

  void setAuth(AuthModel? value) {
    _authModel = value;
    _streamController.add(_authModel);
  }

  @override
  Stream<AuthModel?> get authStream => _streamController.stream;

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
    _streamController.close();
  }
}
