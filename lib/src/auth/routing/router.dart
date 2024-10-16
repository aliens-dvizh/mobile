import 'package:auto_route/auto_route.dart';

import '../../../core/router/auto_route.gr.dart';

@AutoRouterConfig()
class AuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes =>
      [AutoRoute(page: SingInRoute.page, path: 'auth')];
}
