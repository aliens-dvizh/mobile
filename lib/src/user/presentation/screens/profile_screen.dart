import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';
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

  VoidCallback _toSettings(BuildContext context) => () {
    context.push('/settings');
  };


  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: _toSettings(context), icon: Icon(Icons.menu)),
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  print('UserBloc $state');
                  return switch (state) {
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
                  };
                }
              ),
            ],
          ),
        ),
      );

}
