// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/auth/data/export.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/dependencies/iauth_dependencies.dart';

class AuthDependencyContainer extends DependencyContainer<RootLibrary>
    implements IAuthDependency {
  AuthDependencyContainer({required super.parent});

  @override
  late final IAuthRepository authRepository;

  @override
  Future<void> init() async {
    authRepository = AuthRepository(
      TokenDataSource(
        const FlutterSecureStorage(),
      ),
      AuthDataSource(
        parent.dioService,
      ),
      AuthInterceptorDataSource(
        parent.dioService,
      ),
    );
  }
}
