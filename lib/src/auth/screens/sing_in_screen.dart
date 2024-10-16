import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sign_in/sign_in_cubit.dart';
import '../view/export.dart';

@RoutePage()
class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          return switch (state) {
            SignLoginState() => LoginView(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            SingVerifyState() => VerifyView(
                email: state.email,
              ),
            SingRegisterState() => RegisterView(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
          };
        },
      ),
    );
  }
}
