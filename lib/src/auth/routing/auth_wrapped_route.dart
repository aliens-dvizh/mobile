import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:dvizh_mob/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../bloc/auth/auth_bloc.dart';
import '../data/export.dart';

@RoutePage()
class AuthWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  const AuthWrappedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Dependencies(
      library: AuthLibrary(
        parent: Dependencies.of<RootLibrary>(context),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              Dependencies.of<AuthLibrary>(context).authRepository,
            ),
          ),
        ],
        child: this,
      ),
    );
  }
}

class AuthLibrary extends DependenciesLibrary<RootLibrary> {

  late final AuthRepository authRepository;

  AuthLibrary({required super.parent});

  @override
  Future<void> init() async {
    authRepository = AuthRepository(
      TokenDataSource(
        FlutterSecureStorage(),
      ),
      AuthDataSource(
        parent.dioService,
      ),
      AuthInterceptorDataSource(
        parent.dioService,
      ),
    );
  }
}