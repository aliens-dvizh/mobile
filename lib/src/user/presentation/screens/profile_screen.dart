// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/router/auto_route.gr.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  VoidCallback _toSingIn(BuildContext context) =>
      () => AutoRouter.of(context).push(const SingInRoute());

  @override
  Widget build(BuildContext context) => Center(
        child: ButtonWidget(
          onPressed: _toSingIn(context),
          child: const Text('Авторизоваться'),
        ),);
}
