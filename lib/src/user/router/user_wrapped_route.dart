// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/auth/dependencies/iauth_dependencies.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/dependencies/iuser_dependency_container.dart';
import 'package:dvizh_mob/src/user/dependencies/mock_user_dependency_container.dart';
import 'package:dvizh_mob/src/user/dependencies/user_dependency_container.dart';

@RoutePage()
class UserWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) =>
      DependencyScope<IUserDependencyContainer>(
        dependency: kDebugMode
            ? MockUserDependencyContainer()
            : UserDependencyContainer(
                parent: DependencyProvider.of<RootLibrary>(context)),
        builder: (context) => BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            DependencyProvider.of<IUserDependencyContainer>(context)
                .userRepository,
            DependencyProvider.of<IAuthDependency>(context).authRepository,
          ),
          child: this,
        ),
      );
}
