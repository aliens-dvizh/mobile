import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../data/auth_repository.dart';

@RoutePage()
class AuthWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  const AuthWrappedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            context.read<AuthRepository>(),
          ),
        ),
      ],
      child: this,
    );
  }
}
