import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/auth/bloc/auth_logout/auth_logout_bloc.dart';
import 'package:dvizh_mob/src/auth/bloc/delete_account/delete_account_bloc.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutView extends StatelessWidget {
  Future<void> view(BuildContext context) => showDialog(
        context: context,
        builder: (context) => BlocProvider<AuthLogoutBloc>(
          create: (context) => AuthLogoutBloc(
            context.depend<RootDependencyContainer>().authRepository,
          ),
          child: this,
        ),
      );

  VoidCallback _cancel(BuildContext context) => () {
        context.pop();
      };

  VoidCallback _okay(BuildContext context) => () {
        context.read<AuthLogoutBloc>().add(AuthLogoutFetchEvent());
      };

  void _listener(BuildContext context, AuthLogoutState state) {
    if (state is AuthLogoutSuccess) return context.pop();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text('Вы точно хотите выйти из аккаунт?'),
        actions: [
          ElevatedButton(onPressed: _cancel(context), child: Text('Отмена')),
          BlocConsumer<AuthLogoutBloc, AuthLogoutState>(
            listener: _listener,
            builder: (context, state) => switch (state) {
              AuthLogoutInitial() ||
              AuthLogoutError() ||
              AuthLogoutSuccess() =>
                ElevatedButton(
                  onPressed: _okay(context),
                  child: Text('Точно'),
                ),
              AuthLogoutLoading() => ElevatedButton(
                  onPressed: () {},
                  child: CupertinoActivityIndicator(),
                ),
            },
          )
        ],
      );
}
