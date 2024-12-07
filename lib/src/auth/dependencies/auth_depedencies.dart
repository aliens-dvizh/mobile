// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';

class AuthDependencyContainer extends DependencyContainer {
  AuthDependencyContainer({required this.authRepository});

  final IAuthRepository authRepository;
}
