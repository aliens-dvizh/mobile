// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/export.dart';

@RoutePage()
class SingInScreen extends StatefulWidget implements AutoRouteWrapper {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    final authRepository = Dependencies.of<AuthLibrary>(context).authRepository;
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
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<SignInCubit, SignInState>(
              builder: (context, state) => switch (state) {
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
              },
            ),
          ),
        ),
      );
}
