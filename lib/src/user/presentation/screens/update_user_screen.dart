// 🐦 Flutter imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/user/bloc/update/update_user_bloc.dart';
import 'package:dvizh_mob/src/user/router/user_wrapped_route.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:fform/fform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/kit/components/components.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

@RoutePage()
class UpdateUserScreen extends StatefulWidget implements AutoRouteWrapper {
  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => UpdateUserBloc(
            Dependencies.of<UserLibrary>(context).userRepository),
      );
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late TextEditingController _nameController;
  late FForm _form;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _setControllers();
  }

  void _setControllers() {
    switch (context.read<UserBloc>().state) {
      case UserInitialState() || UserLoadingState() || UserExceptionState():
        {}
      case UserLoadedState(:UserModel user):
        {
          _nameController.text = user.name;
        }
    }
  }

  void _change() {}

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: FFormBuilder(
            form: _form,
            builder: (context, form) => ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextFieldWidget(
                  controller: _nameController,
                ),
                BlocBuilder<UpdateUserBloc, UpdateUserState>(
                  builder: (context, state) => ButtonWidget(
                    isLoading: state is UpdateUserLoadingState,
                    onPressed: _change,
                    child: const Text('Change'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
