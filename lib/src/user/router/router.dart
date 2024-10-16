import 'package:auto_route/auto_route.dart';
import 'package:dvizh_mob/core/router/auto_route.gr.dart';

class ProfileRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ];
}
