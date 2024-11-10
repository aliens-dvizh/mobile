// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/annotations.dart';
import 'package:fform/fform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/kit/components/components.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

@RoutePage()
class UpdateUserScreen extends StatefulWidget {
  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
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
                      ButtonWidget(
                        onPressed: _change,
                        child: const Text('Change'),
                      )
                    ],
                  )),
        ),
      );
}
