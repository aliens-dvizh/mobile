import 'package:flutter/material.dart';
import 'package:depend/depend.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/auto_route.dart';
import 'package:toptom_widgetbook/kit/export.dart';

class MyApp extends StatelessWidget {
  final RootDependencyContainer container;

  MyApp({required this.container, super.key})
      : _appRouter = Routing(
          observer: TalkerRouteObserver(
            container.talker,
          ),
        );

  final Routing _appRouter;

  @override
  Widget build(BuildContext context) => ThemeSwitcher(
        child: DependencyProvider(
          dependency: container,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: _appRouter.router,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
              )
              // pageTransitionsTheme: const PageTransitionsTheme(
              //   builders: <TargetPlatform, PageTransitionsBuilder>{
              //     TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              //     TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
              //     TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
              //   },
              // ),
            ),
          ),
        ),
      );
}
