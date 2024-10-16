import 'package:depend/depend.dart';
import 'package:dvizh_mob/core/services/talker/talker_service.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'core/router/auto_route.dart';

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          TalkerRouteObserver(
              Dependencies.of(context).get<TalkerService>().talker),
        ],
      ),
    );
  }
}
