// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/data/sources/auth_data_source.dart';
import 'package:dvizh_mob/src/auth/data/sources/auth_interceptor_data_source.dart';
import 'package:dvizh_mob/src/auth/data/sources/token_data_source.dart';
import 'package:dvizh_mob/src/auth/models/export.dart';
import 'package:dvizh_mob/src/auth/params/export.dart';

class AuthRepository extends IAuthRepository {
  AuthRepository(
    this._tokenSource,
    this._authSource,
    this._authInterceptorSource,
  ) : _authController = StreamController<AuthModel?>.broadcast();

  final TokenDataSource _tokenSource;
  final AuthDataSource _authSource;
  final AuthInterceptorDataSource _authInterceptorSource;
  final StreamController<AuthModel?> _authController;
  late AuthModel? _auth;

  @override
  Stream<AuthModel?> get authStream => _authController.stream;

  @override
  Future<void> register(RegisterParams params) => _authSource.register(params);

  @override
  Future<void> login(LoginParams params) async =>
      await _authSource.login(params).then(_loginCallback);

  @override
  Future<void> verify(VerifyParams params) =>
      _authSource.verify(params).then(_loginCallback);

  @override
  Future<AuthModel> refreshToken(AuthModel auth) =>
      _authSource.refresh(auth).then(_refreshCallback);

  @override
  Future<void> logout() => _authSource.logout().then((value) {
        clear();
      }).catchError((err) {
        clear();
      });

  Future<AuthModel> _refreshCallback(AuthDto value) async {
    _auth = value.toModel();
    await _tokenSource.write(_auth!);
    _authInterceptorSource.set(_auth!, this);
    _authController.add(_auth);
    return _auth!;
  }

  Future<void> _loginCallback(AuthDto value) async {
    _auth = value.toModel();
    await _tokenSource.write(_auth!);
    _authInterceptorSource.set(_auth!, this);
    _authController.add(_auth);
  }

  Future<void> clear() async {
    await _tokenSource.clear();
    _authInterceptorSource.remove();
    _authController.add(null);
  }

  @override
  Future<AuthModel?> get auth async {
    if (_auth == null) {
      _auth = (await _tokenSource.read())?.toModel();
      if (_auth != null) {
        _authInterceptorSource.set(_auth!, this);
      }
    }
    return _auth;
  }

  @override
  Future<void> deleteAccount(DeleteAccountParams params) =>
      _authSource.deleteAccount(params).then((value) => clear());

  @override
  void dispose() {
    _authController.close();
  }
}
