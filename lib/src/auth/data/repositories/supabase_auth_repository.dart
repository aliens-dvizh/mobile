import 'dart:async';

import 'package:dvizh_mob/src/auth/data/export.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/models/auth_dto.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';
import 'package:dvizh_mob/src/auth/params/delete_account_params.dart';
import 'package:dvizh_mob/src/auth/params/login_params_with_email.dart';
import 'package:dvizh_mob/src/auth/params/login_params_with_phone.dart';
import 'package:dvizh_mob/src/auth/params/register_params.dart';
import 'package:dvizh_mob/src/auth/params/verify_params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository extends IAuthRepository {
  SupabaseAuthRepository(
    this._tokenSource,
    this._authInterceptorSource, this._client,
  ) : _authController = StreamController<AuthModel?>.broadcast();

  final TokenDataSource _tokenSource;
  final AuthInterceptorDataSource _authInterceptorSource;
  final StreamController<AuthModel?> _authController;
  AuthModel? _auth;
  final SupabaseClient _client;

  @override
  StreamSubscription<AuthModel?> on(void Function(AuthModel?) callback) =>
      _authController.stream.listen(callback);

  @override
  Future<void> register(RegisterParams params) async {
    await _client.auth.signUp(
      password: params.password,
      phone: params.phone,
      channel: OtpChannel.sms,
      data: {
        'name': params.name,
      }
    );
  }

  @override
  Future<void> login(LoginParamsWithEmail params) async => throw Exception();

  @override
  Future<void> loginWithPhone(LoginParamsWithPhone params) async {

    final response = await _client.auth.signInWithPassword(
      password: params.password,
      phone: params.phone,
    );
    _auth = AuthModel(
      token: response.session!.accessToken,
      refreshToken: response.session!.refreshToken!,
    );

    await _tokenSource.write(_auth!);
    _authInterceptorSource.set(_auth!, this);
    _authController.add(_auth);
  }

  @override
  Future<void> verify(VerifyParams params) async{
    final res = await _client.auth.verifyOTP(
      type: OtpType.sms,
      token: params.code,
      phone: params.phone,
    );

    _auth = AuthModel(
      token: res.session!.accessToken,
      refreshToken: res.session!.refreshToken!,
    );

    await _tokenSource.write(_auth!);
    _authInterceptorSource.set(_auth!, this);
    _authController.add(_auth);
  }

  @override
  Future<AuthModel> refreshToken(AuthModel auth) async {
    print('AUTH ${auth.refreshToken}');
    final res = await _client.auth.refreshSession(
      auth.refreshToken,
    );

    _auth = AuthModel(
      token: res.session!.accessToken,
      refreshToken: res.session!.refreshToken!,
    );

    await _tokenSource.write(_auth!);
    _authInterceptorSource.set(_auth!, this);
    _authController.add(_auth);

    return _auth!;
  }

  @override
  Future<void> logout() => _client.auth.signOut().then((value) {
    clear();
  }).catchError((value) {
    clear();
  });

  @override
  Future<void> clear() async {
    await _tokenSource.clear();
    _authInterceptorSource.remove();
    _authController.add(null);
  }

  @override
  Future<AuthModel?> get auth async {
    print('GET AUTH');
    if (_auth == null) {
      print('AUTH == NULL');

      _auth = (await _tokenSource.read())?.toModel();
      print('AUTH == $_auth');

      if (_auth != null) {
        _authInterceptorSource.set(_auth!, this);
      }
    }
    return _auth;
  }

  @override
  Future<void> deleteAccount(DeleteAccountParams params) async {
    throw Exception();
  }

  @override
  void dispose() {
    _authController.close();
  }
}
