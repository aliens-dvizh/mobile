// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';

class UserDependencyContainer extends DependencyContainer {
  UserDependencyContainer({required this.userRepository});

  final IUserRepository userRepository;
}
