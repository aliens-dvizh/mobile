// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/models/auth_model.dart';
import 'package:dvizh_mob/src/auth/params/delete_account_params.dart';
import 'package:dvizh_mob/src/auth/params/login_params_with_email.dart';
import 'package:dvizh_mob/src/auth/params/login_params_with_phone.dart';
import 'package:dvizh_mob/src/auth/params/register_params.dart';
import 'package:dvizh_mob/src/auth/params/verify_params.dart';
import 'package:dvizh_mob/src/core/models/repository/repository.dart';

abstract class IAuthRepository extends IRepository {
  Future<AuthModel?> get auth;

  StreamSubscription<AuthModel?> on(void Function(AuthModel?) callback);

  Future<void> register(RegisterParams params);

  Future<void> login(LoginParamsWithEmail params);

  Future<void> loginWithPhone(LoginParamsWithPhone params);

  Future<void> verify(VerifyParams params);

  Future<AuthModel> refreshToken(AuthModel auth);

  Future<void> logout();

  Future<void> deleteAccount(DeleteAccountParams params);

  Future<void> clear();
}
