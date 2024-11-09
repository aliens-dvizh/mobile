// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:talker_flutter/talker_flutter.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/router/auto_route.dart';
import 'package:dvizh_mob/main.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _appRouter.config(
          navigatorObservers: () => [
            TalkerRouteObserver(
              Dependencies.of<RootLibrary>(context).talker,
            ),
          ],
        ),
      );
}
