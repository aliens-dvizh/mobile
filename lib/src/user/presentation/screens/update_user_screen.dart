// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:fform/fform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/kit/components/components.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/bloc/update/update_user_bloc.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/dependencies/user_dependency_container.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';
import 'package:dvizh_mob/src/user/forms/update_form.dart';

@RoutePage()
class UpdateUserScreen extends StatefulWidget implements AutoRouteWrapper {
  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => UpdateUserBloc(
          context.depend<UserDependencyContainer>().userRepository,
        ),
        child: this,
      );
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late TextEditingController _nameController;
  late UpdateUserForm _form;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _form = UpdateUserForm.notFilled();
    _setControllers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _form.dispose();
    super.dispose();
  }

  void _setControllers() => switch (context.read<UserBloc>().state) {
        UserLoadedState(:UserModel user) => _nameController.text = user.name,
        _ => null,
      };

  void _change() {
    _form.name.value = _nameController.value.text;
    if (_form.check()) {
      context.read<UpdateUserBloc>().add(UpdateUserEvent());
    }
  }

  void _listenerUpdate(
    BuildContext context,
    UpdateUserState state,
  ) =>
      switch (state) {
        UpdateUserLoadedState() => context.router.maybePop(),
        _ => null,
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: FFormBuilder<UpdateUserForm>(
            form: _form,
            builder: (context, form) => ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextFieldWidget(
                  controller: _nameController,
                ),
                BlocConsumer<UpdateUserBloc, UpdateUserState>(
                  listener: _listenerUpdate,
                  builder: (context, state) => ButtonWidget(
                    isLoading: state is UpdateUserLoadingState ||
                        form.status == FFormStatus.loading,
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
