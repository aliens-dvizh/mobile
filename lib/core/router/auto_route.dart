import 'package:auto_route/auto_route.dart';
import 'package:dvizh_mob/core/router/auto_route.gr.dart';

import '../../src/events/export.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final EventRouter _eventRouter = EventRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/', children: [
          ..._eventRouter.routes,
        ])
      ];
}
