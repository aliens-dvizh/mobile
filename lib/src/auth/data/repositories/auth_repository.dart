// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:dvizh_mob/src/auth/params/delete_account_params.dart';
import 'package:dvizh_mob/src/auth/params/login_params_with_email.dart';
import 'package:dvizh_mob/src/auth/params/login_params_with_phone.dart';
import 'package:dvizh_mob/src/auth/params/register_params.dart';
import 'package:dvizh_mob/src/auth/params/verify_params.dart';
import 'package:event_truck/event_truck.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/data/sources/auth_data_source.dart';
import 'package:dvizh_mob/src/auth/data/sources/auth_interceptor_data_source.dart';
import 'package:dvizh_mob/src/auth/data/sources/token_data_source.dart';
import 'package:dvizh_mob/src/auth/models/export.dart';

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
  StreamSubscription<AuthModel?> on(void Function(AuthModel?) callback) =>
      _authController.stream.listen(callback);

  @override
  Future<void> register(RegisterParams params) => _authSource.register(params);

  @override
  Future<void> login(LoginParamsWithEmail params) async =>
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

  @override
  Future<void> loginWithPhone(LoginParamsWithPhone params) {
    // TODO: implement loginWithPhone
    throw UnimplementedError();
  }
}
