// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/auth/bloc/auth/auth_bloc.dart';
import 'package:dvizh_mob/src/auth/data/export.dart';

@RoutePage()
class AuthWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  const AuthWrappedScreen({super.key});

  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) => Dependencies(
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

class AuthLibrary extends DependenciesLibrary<RootLibrary> {
  AuthLibrary({required super.parent});
  late final AuthRepository authRepository;

  @override
  Future<void> init() async {
    authRepository = AuthRepository(
      TokenDataSource(
        const FlutterSecureStorage(),
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
