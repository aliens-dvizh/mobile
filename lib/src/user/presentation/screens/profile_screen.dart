// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/router/auto_route.gr.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  VoidCallback _toSingIn(BuildContext context) =>
      () => AutoRouter.of(context).push(const SingInRoute());

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => switch (state) {
              UserInitialState() || UserLoadingState() => Center(
                  child: ButtonWidget(
                    onPressed: _toSingIn(context),
                    child: const Text('Авторизоваться'),
                  ),
                ),
              UserLoadedState(:UserModel user) => Text(user.name),
              UserExceptionState() => const Text('Exception'),
            },
          ),
        ),
      );
}
