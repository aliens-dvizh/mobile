// 📦 Package imports:
import 'package:auto_route/auto_route.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/router/auto_route.gr.dart';

class EventRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: EventWrappedRoute.page,
          path: 'events',
          children: [
            AutoRoute(
              page: EventsRoute.page,
              initial: true,
              path: '',
            ),
            AutoRoute(
              page: EventRoute.page,
              path: ':id',
            ),
          ],
        ),
      ];
}
