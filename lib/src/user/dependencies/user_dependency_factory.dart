// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';
import 'package:dvizh_mob/src/user/data/repositories/mock_repository.dart';
import 'package:dvizh_mob/src/user/data/repositories/user_repository.dart';
import 'package:dvizh_mob/src/user/data/source/user_data_source.dart';
import 'package:dvizh_mob/src/user/dependencies/user_dependency_container.dart';

class UserDependencyFactory extends DependencyFactory<UserDependencyContainer> {
  UserDependencyFactory({
    required bool useMocks,
    required DioService dioService,
  })  : _useMocks = useMocks,
        _dioService = dioService;

  final bool _useMocks;
  final DioService _dioService;

  @override
  Future<UserDependencyContainer> create() async {
    final repository = _useMocks
        ? MockUserRepository()
        : UserRepository(
            dataSource: UserDataSource(
              dioService: _dioService,
            ),
          );

    return UserDependencyContainer(
      userRepository: repository,
    );
  }
}
