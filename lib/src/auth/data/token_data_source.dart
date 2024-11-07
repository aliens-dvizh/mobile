// 📦 Package imports:

// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/models/export.dart';

class TokenDataSource {
  TokenDataSource(this._storage);

  static const String _keyToken = 'token';
  static const String _keyRefreshToken = 'refresh_token';

  final FlutterSecureStorage _storage;

  Future<void> write(AuthModel auth) async {
    await _storage.write(key: _keyToken, value: auth.token);
    await _storage.write(key: _keyRefreshToken, value: auth.refreshToken);
  }

  Future<void> clear() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyRefreshToken);
  }

  Future<AuthDto?> read() async {
    try {
      var token = await _storage.read(key: _keyToken);
      var refreshToken = await _storage.read(key: _keyRefreshToken);

      if (token == null || refreshToken == null) return null;

      return AuthDto(token, refreshToken);
    } on Exception {
      return null;
    }
  }
}
