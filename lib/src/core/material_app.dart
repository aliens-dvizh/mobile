// 🐦 Flutter imports:
import 'package:dvizh_mob/src/theme/domain/blocs/theme_cubit.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
// 🌎 Project imports:
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/auto_route.dart';
import 'package:toptom_widgetbook/kit/export.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key}) : _appRouter = Routing();


  final Routing _appRouter;

  @override
  Widget build(BuildContext context) =>
      ThemeSwitcher(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.router(
            TalkerRouteObserver(
              DependencyProvider.of<RootDependencyContainer>(context)
                  .talker,
            ),
          ),
        ),
      );
}
