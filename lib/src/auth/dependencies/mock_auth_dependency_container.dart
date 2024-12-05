// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/data/repositories/mock_auth_repository.dart';
import 'package:dvizh_mob/src/auth/dependencies/iauth_dependencies.dart';

class MockAuthDependencyContainer extends DependencyContainer<RootLibrary>
    implements IAuthDependency {
  MockAuthDependencyContainer();

  @override
  Future<void> init() async {
    authRepository = MockAuthRepository();
  }

  @override
  late IAuthRepository authRepository;
}
