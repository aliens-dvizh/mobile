import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  VoidCallback _toSingIn(BuildContext context) => () {
        context.push('/auth');
      };

  VoidCallback _toUpdate(BuildContext context) => () {
        context.push('/profile/update');
      };

  VoidCallback _toSettings(BuildContext context) => () {
        context.push('/settings');
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: _toSettings(context),
                icon: Icon(Icons.menu),
              ),
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) => SliverList.list(
                children: [
                  ...switch (state) {
                    UserInitialState() || UserLoadingState() => [
                        Center(
                          child: ButtonWidget(
                            onPressed: _toSingIn(context),
                            child: const Text('Авторизоваться'),
                          ),
                        ),
                      ],
                    UserLoadedState(:UserModel user) => [
                      Text(user.name),
                      ],
                    UserExceptionState() => [
                        const Text('Exception'),
                      ]
                  },
                ],
              ),
            )
          ],
        ),
      );
}
