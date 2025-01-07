// 🐦 Flutter imports:
import 'package:dvizh_mob/src/theme/domain/blocs/theme_cubit.dart';
import 'package:dvizh_mob/src/theme/domain/models/theme_type.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  VoidCallback _toSingIn(BuildContext context) =>
      () {
        context.push('/auth');
      };

  VoidCallback _toUpdate(BuildContext context) =>
      () {
        context.push('/profile/update');

      };

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) => switch (state) {
                  UserInitialState() || UserLoadingState() => Center(
                      child: ButtonWidget(
                        onPressed: _toSingIn(context),
                        child: const Text('Авторизоваться'),
                      ),
                    ),
                  UserLoadedState(:UserModel user) => Column(
                      children: [
                        Text(user.name),
                        ElevatedButton(
                          onPressed: _toUpdate(context),
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  UserExceptionState() => const Text('Exception'),
                },
              ),
            ],
          ),
        ),
      );

}
