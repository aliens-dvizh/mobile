// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';
import 'package:dvizh_mob/src/user/data/repositories/user_repository.dart';
import 'package:dvizh_mob/src/user/data/source/user_data_source.dart';
import 'package:dvizh_mob/src/user/dependencies/iuser_dependency_container.dart';

class UserDependencyContainer extends DependencyContainer<RootLibrary>
    implements IUserDependencyContainer {
  UserDependencyContainer({required super.parent});

  @override
  late final IUserRepository userRepository;

  @override
  Future<void> init() async {
    userRepository = UserRepository(
      dataSource: UserDataSource(
        dioService: parent.dioService,
      ),
    );
  }
}
