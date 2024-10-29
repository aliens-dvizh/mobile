// 📦 Package imports:
import 'package:auto_route/auto_route.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/router/auto_route.gr.dart';
import '../../src/auth/export.dart';
import '../../src/events/export.dart';
import '../../src/user/export.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final EventRouter _eventRouter = EventRouter();
  final ProfileRouter _profileRouter = ProfileRouter();
  final AuthRouter _authRouter = AuthRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthWrappedRoute.page,
          path: '/',
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
      ];
}
