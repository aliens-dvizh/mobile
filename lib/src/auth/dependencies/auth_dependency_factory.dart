// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/export.dart';
import 'package:dvizh_mob/src/auth/data/repositories/mock_auth_repository.dart';
import 'package:dvizh_mob/src/auth/dependencies/auth_depedencies.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';

class AuthDependencyFactory extends DependencyFactory<AuthDependencyContainer> {
  AuthDependencyFactory(
      {required bool useMocks,
      required DioService dioService,
      required FlutterSecureStorage secureStorage})
      : _useMocks = useMocks,
        _dioService = dioService,
        _secureStorage = secureStorage;

  final bool _useMocks;
  final DioService _dioService;
  final FlutterSecureStorage _secureStorage;

  @override
  Future<AuthDependencyContainer> create() async {
    final repository = _useMocks
        ? MockAuthRepository()
        : AuthRepository(
            TokenDataSource(
              _secureStorage,
            ),
            AuthDataSource(
              _dioService,
            ),
            AuthInterceptorDataSource(
              _dioService,
            ),
          );

    return AuthDependencyContainer(
      authRepository: repository,
    );
  }
}
