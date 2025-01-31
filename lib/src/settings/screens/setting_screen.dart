import 'package:dvizh_mob/src/auth/bloc/auth/auth_bloc.dart';
import 'package:dvizh_mob/src/auth/presentation/view/delete_account_view.dart';
import 'package:dvizh_mob/src/auth/presentation/view/logout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {

  VoidCallback _toUpdate(BuildContext context) =>
          () {
        context.push('/profile/update');
      };

  VoidCallback _toAuthorization(BuildContext context) =>
          () {
        context.push('/auth');
      };

  VoidCallback _delete(BuildContext context) =>
          () {
        DeleteAccountView().view(context);
      };

  VoidCallback _logout(BuildContext context) =>
          () {
        LogoutView().view(context);
      };

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if(state is AuthIsSign) ...[
                      ListTile(
                        onTap: _toUpdate(context),
                        title: Text('Изменить профиль'),
                      ),
                      ListTile(
                        title: Text('Мои билеты'),
                      ),
                      ListTile(
                        onTap: _delete(context),
                        title: Text('Удалить профиль'),
                      ),
                      Divider(),
                      ListTile(
                        onTap: _logout(context),
                        title: Text('Выйти'),
                        trailing: Icon(Icons.exit_to_app),
                      ),
                    ],
                    if(state is AuthIsNotSign) ...[
                      ListTile(
                        onTap: _toAuthorization(context),
                        title: Text('Авторизоваться'),
                      ),
                    ],
                    ListTile(
                      title: Text('Пользовательское соглашение'),
                    ),
                    ListTile(
                      title: Text('Политика конфиденциальности'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

}