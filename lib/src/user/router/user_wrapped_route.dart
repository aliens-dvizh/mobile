// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/auth/dependencies/auth_depedencies.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/dependencies/user_dependency_container.dart';
import 'package:dvizh_mob/src/user/dependencies/user_dependency_factory.dart';

@RoutePage()
class UserWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) =>
      DependencyScope<UserDependencyContainer, UserDependencyFactory>(
        factory: UserDependencyFactory(
          useMocks: context.depend<RootLibrary>().settings.useMocks,
          dioService: context.depend<RootLibrary>().dioService,
        ),
        builder: (context) => BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            DependencyProvider.of<UserDependencyContainer>(context)
                .userRepository,
            DependencyProvider.of<AuthDependencyContainer>(context)
                .authRepository,
          ),
          child: this,
        ),
      );
}
