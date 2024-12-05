// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/auth/bloc/auth/auth_bloc.dart';
import 'package:dvizh_mob/src/auth/dependencies/auth_depedencies.dart';
import 'package:dvizh_mob/src/auth/dependencies/iauth_dependencies.dart';
import 'package:dvizh_mob/src/auth/dependencies/mock_auth_dependency_container.dart';

@RoutePage()
class AuthWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  const AuthWrappedScreen({super.key});

  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) => DependencyScope<IAuthDependency>(
        dependency: kDebugMode
            ? MockAuthDependencyContainer()
            : AuthDependencyContainer(
                parent: DependencyProvider.of<RootLibrary>(context),
              ),
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                DependencyProvider.of<IAuthDependency>(context).authRepository,
              ),
            ),
          ],
          child: this,
        ),
      );
}
