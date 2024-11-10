// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart' as _i11;

// 📦 Package imports:
import 'package:auto_route/auto_route.dart' as _i10;

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/routing/auth_wrapped_route.dart' as _i1;
import 'package:dvizh_mob/src/core/router/core_wrapped_route.dart' as _i2;
import 'package:dvizh_mob/src/events/router/event_wrapped_route.dart' as _i4;
import 'package:dvizh_mob/src/user/router/user_wrapped_route.dart' as _i9;

import 'package:dvizh_mob/src/auth/presentation/screens/sing_in_screen.dart'
    as _i8;
import 'package:dvizh_mob/src/events/presentation/screens/event_screen.dart'
    as _i3;
import 'package:dvizh_mob/src/events/presentation/screens/events_screen.dart'
    as _i5;
import 'package:dvizh_mob/src/main/presentation/screens/home_screen.dart'
    as _i6;
import 'package:dvizh_mob/src/user/presentation/screens/profile_screen.dart'
    as _i7;

/// generated route for
/// [_i1.AuthWrappedScreen]
class AuthWrappedRoute extends _i10.PageRouteInfo<void> {
  const AuthWrappedRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AuthWrappedRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthWrappedRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.WrappedRoute(child: const _i1.AuthWrappedScreen());
    },
  );
}

/// generated route for
/// [_i2.CoreWrappedScreen]
class CoreWrappedRoute extends _i10.PageRouteInfo<void> {
  const CoreWrappedRoute({List<_i10.PageRouteInfo>? children})
      : super(
          CoreWrappedRoute.name,
          initialChildren: children,
        );

  static const String name = 'CoreWrappedRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.WrappedRoute(child: _i2.CoreWrappedScreen());
    },
  );
}

/// generated route for
/// [_i3.EventScreen]
class EventRoute extends _i10.PageRouteInfo<EventRouteArgs> {
  EventRoute({
    required int id,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          EventRoute.name,
          args: EventRouteArgs(
            id: id,
            key: key,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EventRouteArgs>(
          orElse: () => EventRouteArgs(id: pathParams.getInt('id')));
      return _i3.EventScreen(
        id: args.id,
        key: args.key,
      );
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({
    required this.id,
    this.key,
  });

  final int id;

  final _i11.Key? key;

  @override
  String toString() {
    return 'EventRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i4.EventWrappedScreen]
class EventWrappedRoute extends _i10.PageRouteInfo<void> {
  const EventWrappedRoute({List<_i10.PageRouteInfo>? children})
      : super(
          EventWrappedRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventWrappedRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.WrappedRoute(child: const _i4.EventWrappedScreen());
    },
  );
}

/// generated route for
/// [_i5.EventsScreen]
class EventsRoute extends _i10.PageRouteInfo<void> {
  const EventsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          EventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.EventsScreen();
    },
  );
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}

/// generated route for
/// [_i7.ProfileScreen]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i8.SingInScreen]
class SingInRoute extends _i10.PageRouteInfo<void> {
  const SingInRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SingInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SingInRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.WrappedRoute(child: const _i8.SingInScreen());
    },
  );
}

/// generated route for
/// [_i9.UserWrappedScreen]
class UserWrappedRoute extends _i10.PageRouteInfo<void> {
  const UserWrappedRoute({List<_i10.PageRouteInfo>? children})
      : super(
          UserWrappedRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserWrappedRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.WrappedRoute(child: _i9.UserWrappedScreen());
    },
  );
}
