import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/auth/bloc/auth/auth_bloc.dart';
import 'package:dvizh_mob/src/city/bloc/categories_bloc/categories_bloc.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/city_from_ip_bloc/city_from_ip_bloc.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/current_location/current_location_bloc.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/current_location_view/current_location_view_cubit.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

interface class WrappedRoute {
  Widget wrappedRoute(BuildContext context) {
    throw Exception();
  }
}

class MainWrapped implements WrappedRoute {
  MainWrapped({required this.child});

  final Widget child;

  @override
  Widget wrappedRoute(BuildContext context) {
    final container = DependencyProvider.of<RootDependencyContainer>(context);

    return MultiBlocProvider(
      providers: [

        BlocProvider<AuthBloc>(
          lazy: false,
          create: (context) => AuthBloc(container.authRepository),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            container.userRepository,
            container.authRepository,
          ),
        ),
        BlocProvider<CurrentLocationBloc>(
          lazy: true,
          create: (context) => CurrentLocationBloc(
            container.currentLocationRepository,
          ),
        ),
        BlocProvider<CitiesBloc>(
          lazy: true,
          create: (context) => CitiesBloc(
            container.cityRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
