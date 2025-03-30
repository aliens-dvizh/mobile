// 🐦 Flutter imports:
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/user/params/update_params.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:fform/fform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toptom_widgetbook/kit/components/components.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/bloc/update/update_user_bloc.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';
import 'package:dvizh_mob/src/user/forms/update_form.dart';

class UpdateUserScreen extends StatefulWidget implements WrappedRoute {
  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => UpdateUserBloc(
          context.depend<RootDependencyContainer>().userRepository,
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
      context.read<UpdateUserBloc>().add(
            UpdateUserEvent(
              params: UpdateUserParams(name: _form.name.value),
            ),
          );
    }
  }

  void _listenerUpdate(
    BuildContext context,
    UpdateUserState state,
  ) =>
      switch (state) {
        UpdateUserLoadedState() => context.pop(),
        _ => null,
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Изменить профиль'),
            ),
            // SliverList.list(children: [],),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: FFormBuilder<UpdateUserForm>(
                form: _form,
                builder: (context, form) => SliverList.list(
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
          ],
        ),
      );
}
