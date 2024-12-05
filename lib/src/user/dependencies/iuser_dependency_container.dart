// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';

abstract interface class IUserDependencyContainer
    extends DependencyContainer<RootLibrary> {
  late final IUserRepository userRepository;
}
