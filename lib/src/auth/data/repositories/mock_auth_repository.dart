// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:dvizh_mob/src/auth/data/export.dart';
import 'package:event_truck/event_truck.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';
import 'package:dvizh_mob/src/auth/params/delete_account_params.dart';
import 'package:dvizh_mob/src/auth/params/login_params.dart';
import 'package:dvizh_mob/src/auth/params/register_params.dart';
import 'package:dvizh_mob/src/auth/params/verify_params.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final AuthModel _mock = AuthModel(token: 'token', refreshToken: 'refreshToken');

class MockAuthRepository extends IAuthRepository {
  MockAuthRepository(this._tokenDataSource)
      : _streamController = StreamController<AuthModel?>.broadcast();

  final TokenDataSource _tokenDataSource;

  final StreamController<AuthModel?> _streamController;
  AuthModel? _authModel;

  @override
  Future<AuthModel?> get auth async {
    if (_authModel != null) return _authModel;
    final auth = (await _tokenDataSource.read())?.toModel();
    setAuth(auth);
    return auth;
  }

  void setAuth(AuthModel? value) {
    if(_authModel == value) return;
    _authModel = value;
    _streamController.add(_authModel);
    if (value == null) {
      _tokenDataSource.clear();
    } else
      _tokenDataSource.write(value);
  }

  @override
  StreamSubscription<AuthModel?> on(void Function(AuthModel?) callback) =>
      _streamController.stream.listen(callback);

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
