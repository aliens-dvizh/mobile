// 📦 Package imports:
import 'package:auto_route/auto_route.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/router/auto_route.gr.dart';

class AuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SingInRoute.page,
          path: 'auth',
        ),
      ];
}
