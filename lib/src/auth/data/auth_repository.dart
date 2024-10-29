// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import '../models/export.dart';
import '../params/export.dart';
import 'auth_data_source.dart';
import 'auth_interceptor_data_source.dart';
import 'token_data_source.dart';

class AuthRepository {
  final TokenDataSource _tokenSource;
  final AuthDataSource _authSource;
  final AuthInterceptorDataSource _authInterceptorSource;
  final StreamController<AuthModel?> _authController =
      StreamController<AuthModel?>.broadcast();
  static AuthModel? _auth;

  AuthRepository(
    this._tokenSource,
    this._authSource,
    this._authInterceptorSource,
  );

  Stream<AuthModel?> get authStream => _authController.stream;

  Future register(RegisterParams params) => _authSource.register(params);

  Future<void> login(LoginParams params) async =>
      await _authSource.login(params).then(_loginCallback);

  Future<void> verify(VerifyParams params) =>
      _authSource.verify(params).then(_loginCallback);

  Future<AuthModel> refreshToken(AuthModel auth) =>
      _authSource.refresh(auth).then(_refreshCallback);

  Future<void> logout() => _authSource.logout().then((value) {
        clear();
      }).catchError((err) {
        clear();
      });

  Future<AuthModel> _refreshCallback(AuthDto value) async {
    _auth = value.toModel();
    _tokenSource.write(_auth!);
    _authInterceptorSource.set(_auth!, this);
    _authController.add(_auth);
    return _auth!;
  }

  Future _loginCallback(AuthDto value) async {
    _auth = value.toModel();
    await _tokenSource.write(_auth!);
    _authInterceptorSource.set(_auth!, this);
    _authController.add(_auth);
  }

  Future clear() async {
    await _tokenSource.clear();
    _authInterceptorSource.remove();
    _authController.add(null);
  }

  Future<AuthModel?> get auth async {
    if (_auth == null) {
      _auth = (await _tokenSource.read())?.toModel();
      if (_auth != null) {
        _authInterceptorSource.set(_auth!, this);
      }
    }
    return _auth;
  }

  Future<Response> changeEmail(ChangeEmailParams params) =>
      _authSource.changeEmail(params);

  Future<void> deleteAccount(DeleteAccountParams params) =>
      _authSource.deleteAccount(params).then((value) => clear());
}
