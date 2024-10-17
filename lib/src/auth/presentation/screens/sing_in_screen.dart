import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/auth/bloc/export.dart';
import 'package:dvizh_mob/src/auth/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../export.dart';

@RoutePage()
class SingInScreen extends StatefulWidget implements AutoRouteWrapper {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    final authRepository = Dependencies.of(context).get<AuthRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(
          create: (context) => SignInCubit(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authRepository,
          ),
        ),
        BlocProvider<RegistrationBloc>(
          create: (context) => RegistrationBloc(
            authRepository,
          ),
        ),
        BlocProvider<VerifyBloc>(
          create: (context) => VerifyBloc(
            authRepository,
          ),
        ),
      ],
      child: this,
    );
  }
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
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
        ),
      ),
    );
  }
}
