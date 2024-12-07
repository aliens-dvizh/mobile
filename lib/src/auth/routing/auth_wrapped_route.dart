// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/auth/bloc/auth/auth_bloc.dart';
import 'package:dvizh_mob/src/auth/dependencies/auth_depedencies.dart';
import 'package:dvizh_mob/src/auth/dependencies/auth_dependency_factory.dart';

@RoutePage()
class AuthWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  const AuthWrappedScreen({super.key});

  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) {
    final rootDependency = DependencyProvider.of<RootLibrary>(context);

    return DependencyScope<AuthDependencyContainer, AuthDependencyFactory>(
      factory: AuthDependencyFactory(
        useMocks: rootDependency.settings.useMocks,
        dioService: rootDependency.dioService,
        secureStorage: rootDependency.secureStorage,
      ),
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              DependencyProvider.of<AuthDependencyContainer>(context)
                  .authRepository,
            ),
          ),
        ],
        child: this,
      ),
    );
  }
}
