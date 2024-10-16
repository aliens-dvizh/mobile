import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/export.dart';

class TokenDataSource {
  TokenDataSource(this._storage);

  static const String _keyToken = 'token';
  static const String _keyRefreshToken = 'refresh_token';

  final FlutterSecureStorage _storage;

  Future write(AuthModel auth) async {
    await _storage.write(key: _keyToken, value: auth.token);
    await _storage.write(key: _keyRefreshToken, value: auth.refreshToken);
  }

  Future clear() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyRefreshToken);
  }

  Future<AuthDto?> read() async {
    try {
      String? token = await _storage.read(key: _keyToken);
      String? refreshToken = await _storage.read(key: _keyRefreshToken);

      if (token == null || refreshToken == null) return null;

      return AuthDto(token, refreshToken);
    } catch (err) {
      return null;
    }
  }
}
