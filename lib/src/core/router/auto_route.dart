// 📦 Package imports:

import 'package:dvizh_mob/src/auth/presentation/screens/export.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/presentation/screens/event_screen.dart';
import 'package:dvizh_mob/src/favorite/screens/favorite_screen.dart';
import 'package:dvizh_mob/src/main/export.dart';
import 'package:dvizh_mob/src/settings/screens/setting_screen.dart';
import 'package:dvizh_mob/src/ticket/screens/create_ticket_screen.dart';
import 'package:dvizh_mob/src/ticket/screens/ticket_screen.dart';
import 'package:dvizh_mob/src/ticket/screens/tickets_screen.dart';
import 'package:dvizh_mob/src/user/export.dart';
import 'package:dvizh_mob/src/user/presentation/screens/update_user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class Routing {
  Routing({required this.observer});

  final NavigatorObserver observer;

  late final GoRouter router = GoRouter(
    observers: [observer],
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainWrapped(
          child: child,
        ).wrappedRoute(
          context,
        ),
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, child) => HomeScreen(
              state: state,
              child: child,
            ).wrappedRoute(context),
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/',
                    builder: (context, state) =>
                        const EventsScreen().wrappedRoute(context),

                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/favorite',
                    builder: (context, state) => FavoriteScreen(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/profile',
                    builder: (context, state) => const ProfileScreen(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/event/:id',
            builder: (context, state) => EventScreen(
              params: EventScreenParams.fromMap(state.pathParameters),
            ).wrappedRoute(context),
          ),
          GoRoute(
            path: '/ticket/create/:id',
            builder: (context, state) => CreateTicketScreen(
              params: CreateTicketScreenParams.fromMap(state.pathParameters),
            ).wrappedRoute(context),
          ),
          GoRoute(
            path: '/ticket',
            builder: (context, state) => TicketsScreen(),
          ),
          GoRoute(
            path: '/ticket/:id',
            builder: (context, state) => TicketScreen(
              params: TicketScreenParams.fromMap(state.pathParameters),
            ).wrappedRoute(context),
          ),
          GoRoute(
            path: '/profile/update',
            builder: (context, state) =>
                UpdateUserScreen().wrappedRoute(context),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => SettingScreen(),
          ),
          GoRoute(
            path: '/auth',
            builder: (context, state) =>
                const SingInScreen().wrappedRoute(context),
          ),
        ],
      ),
    ],
  );
}
