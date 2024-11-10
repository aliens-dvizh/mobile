// 📦 Package imports:
import 'package:auto_route/auto_route.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/export.dart';
import 'package:dvizh_mob/src/core/router/auto_route.gr.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/user/export.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final EventRouter _eventRouter = EventRouter();
  final ProfileRouter _profileRouter = ProfileRouter();
  final AuthRouter _authRouter = AuthRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: CoreWrappedRoute.page,
          path: '/',
          children: [
            AutoRoute(
              path: '',
              page: AuthWrappedRoute.page,
              children: [
                AutoRoute(
                  page: HomeRoute.page,
                  path: '',
                  children: [
                    ..._eventRouter.routes,
                    ..._profileRouter.routes,
                  ],
                ),
                ..._authRouter.routes,
              ],
            ),
          ],
        ),
      ];
}
