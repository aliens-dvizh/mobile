// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:synchronized/synchronized.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/services/dio/dio_service.dart';
import 'package:dvizh_mob/src/auth/data/auth_repository.dart';
import 'package:dvizh_mob/src/auth/models/auth_model.dart';

class AuthInterceptor extends AppInterceptor {
  AuthInterceptor(
    this.auth,
    this._authRepository,
  );
  final AuthRepository _authRepository;
  AuthModel auth;
  Lock? _lock;
  Future<void>? _tokenRefreshCall;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Authorization': 'Bearer ${auth.token}'});
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final path = err.response?.requestOptions.path;
    if (err.response?.statusCode == HttpStatus.unauthorized &&
        (path != '/auth/logout')) {
      try {
        late Response<Response<Object?>> response;

        final requestOptions = err.requestOptions;
        if (_tokenRefreshCall == null) {
          _lock = Lock();
          _tokenRefreshCall = _authRepository.refreshToken(auth).then((value) {
            value = value;
            requestOptions.headers['Authorization'] = 'Bearer ${value.token}';
          }).whenComplete(() {
            _lock = null;
            _tokenRefreshCall = null;
          });
        }

        await _lock?.synchronized(() async {
          await _tokenRefreshCall;
        });

        try {
          response = await dio.fetch(requestOptions);
        } on DioException catch (err) {
          if (err.response?.statusCode == HttpStatus.unauthorized) {
            rethrow;
          }
          return handler.resolve(response);
        }
        return handler.resolve(response);
      } on Exception {
        await _authRepository.clear();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }
}
