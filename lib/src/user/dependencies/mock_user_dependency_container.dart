// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';
import 'package:dvizh_mob/src/user/data/repositories/mock_repository.dart';
import 'package:dvizh_mob/src/user/dependencies/iuser_dependency_container.dart';

class MockUserDependencyContainer extends DependencyContainer<RootLibrary>
    implements IUserDependencyContainer {
  MockUserDependencyContainer();

  @override
  late final IUserRepository userRepository;

  @override
  Future<void> init() async {
    userRepository = MockUserRepository();
  }
}
