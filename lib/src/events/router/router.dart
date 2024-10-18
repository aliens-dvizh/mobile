import 'package:auto_route/auto_route.dart';
import 'package:dvizh_mob/core/router/auto_route.gr.dart';

class EventRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: EventsRoute.page,
          initial: true,
          path: 'events',
        ),
      ];
}
