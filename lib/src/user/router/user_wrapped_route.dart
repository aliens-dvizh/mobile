// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/auth/export.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/data/user_data_source.dart';
import 'package:dvizh_mob/src/user/data/user_repository.dart';

@RoutePage()
class UserWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) => Dependencies(
        library: UserLibrary(parent: Dependencies.of<RootLibrary>(context)),
        child: BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            Dependencies.of<UserLibrary>(context).userRepository,
            Dependencies.of<AuthLibrary>(context).authRepository,
          ),
          child: this,
        ),
      );
}

class UserLibrary extends DependenciesLibrary<RootLibrary> {
  UserLibrary({required super.parent});

  late final UserRepository userRepository;

  @override
  Future<void> init() async {
    userRepository = UserRepository(
      dataSource: UserDataSource(
        dioService: parent.dioService,
      ),
    );
  }
}
