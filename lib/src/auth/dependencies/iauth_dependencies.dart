// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';

abstract interface class IAuthDependency
    extends DependencyContainer<RootLibrary> {
  late final IAuthRepository authRepository;
}
