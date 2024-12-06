// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/export.dart';
import 'package:dvizh_mob/src/core/models/repository/repository.dart';

abstract class IAuthRepository extends IRepository {

  Future<AuthModel?> get auth;

  StreamSubscription<AuthModel?> on(void Function(AuthModel?) callback);

  Future<void> register(RegisterParams params);

  Future<void> login(LoginParams params);

  Future<void> verify(VerifyParams params);

  Future<AuthModel> refreshToken(AuthModel auth);

  Future<void> logout();

  Future<void> deleteAccount(DeleteAccountParams params);
}
