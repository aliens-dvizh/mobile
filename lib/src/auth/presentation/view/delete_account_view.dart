import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/auth/bloc/delete_account/delete_account_bloc.dart';
import 'package:dvizh_mob/src/auth/params/delete_account_params.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountView extends StatelessWidget {
  Future<void> view(BuildContext context) => showDialog(
        context: context,
        builder: (context) => BlocProvider<DeleteAccountBloc>(
          create: (context) => DeleteAccountBloc(
            context.depend<RootDependencyContainer>().authRepository,
          ),
          child: this,
        ),
      );

  VoidCallback _cancel(BuildContext context) => () {
        context.pop();
      };

  VoidCallback _okay(BuildContext context) => () {
        context
            .read<DeleteAccountBloc>()
            .add(DeleteAccount(params: DeleteAccountParams(code: 10001)));
      };

  void _listener(BuildContext context, DeleteAccountState state) {
    if(state is DeleteAccountSuccess) return context.pop();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text('Вы точно хотите удалить аккаунт?'),
        actions: [
          ElevatedButton(onPressed: _cancel(context), child: Text('Отмена')),
          BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
            listener: _listener,
            builder: (context, state) => switch (state) {
              DeleteAccountInitial() ||
              DeleteAccountNetworkError() ||
              DeleteAccountError() ||
              DeleteAccountValidationError() ||
              DeleteAccountSuccess() =>
                ElevatedButton(
                  onPressed: _okay(context),
                  child: Text('Согласен'),
                ),
              DeleteAccountLoading() => CupertinoActivityIndicator(),
            },
          )
        ],
      );
}
