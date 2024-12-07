// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:toptom_widgetbook/kit/export.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/auto_route.dart';

class MyApp extends StatelessWidget {
  MyApp({required this.dependency, super.key}) : _appRouter = AppRouter();

  final RootDependencyContainer dependency;

  final AppRouter _appRouter;

  @override
  Widget build(BuildContext context) =>
      DependencyProvider<RootDependencyContainer>(
        dependency: dependency,
        child: ThemeSwitcher(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: _appRouter.config(
              navigatorObservers: () => [
                TalkerRouteObserver(
                  DependencyProvider.of<RootDependencyContainer>(context)
                      .talker,
                ),
              ],
            ),
          ),
        ),
      );
}
