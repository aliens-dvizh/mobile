import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

import '../../../../core/router/auto_route.gr.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  VoidCallback _toSingIn(BuildContext context) =>
      () => AutoRouter.of(context).push(SingInRoute());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonWidget(
        onPressed: _toSingIn(context),
        child: Text('Авторизоваться'),
      ),
    );
  }
}
