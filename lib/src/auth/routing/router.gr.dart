// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:dvizh_mob/src/auth/routing/auth_wrapped_route.dart' as _i1;
import 'package:dvizh_mob/src/auth/screens/sing_in_screen.dart' as _i4;
import 'package:dvizh_mob/src/events/presentation/screens/events_screen.dart'
    as _i2;
import 'package:dvizh_mob/src/main/screens/home_screen.dart' as _i3;

/// generated route for
/// [_i1.AuthWrappedScreen]
class AuthWrappedRoute extends _i5.PageRouteInfo<void> {
  const AuthWrappedRoute({List<_i5.PageRouteInfo>? children})
      : super(
          AuthWrappedRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthWrappedRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i1.AuthWrappedScreen());
    },
  );
}

/// generated route for
/// [_i2.EventsScreen]
class EventsRoute extends _i5.PageRouteInfo<void> {
  const EventsRoute({List<_i5.PageRouteInfo>? children})
      : super(
          EventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i2.EventsScreen());
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}

/// generated route for
/// [_i4.SingInScreen]
class SingInRoute extends _i5.PageRouteInfo<void> {
  const SingInRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SingInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SingInRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SingInScreen();
    },
  );
}
