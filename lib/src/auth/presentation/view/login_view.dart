// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:fform/fform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/export.dart';
import 'package:dvizh_mob/src/core/utils/validation_exception_parses.dart';
import 'package:dvizh_mob/src/forgot/export.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    super.key,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with ValidationExceptionParser {
  final LoginForm _form = LoginForm.parse();

  //METHODS
  Future<void> Function() _loginUser(BuildContext context) => () async {
        _form.change(
          email: widget._emailController.text,
          password: widget._passwordController.text,
        );
        if (_form.isInvalid) return;
        context.read<LoginBloc>().add(
              LoginSubmitted(
                params: LoginParams(
                  email: widget._emailController.text,
                  password: widget._passwordController.text,
                ),
              ),
            );
      };

  void _listener(BuildContext context, LoginState state) {
    switch (state) {
      case LoginSuccess():
        {
          break;
        }
      case LoginRedirectVerifyState():
        {
          context
              .read<SignInCubit>()
              .to(SingVerifyState(widget._emailController.text));
          break;
        }
      default:
        return;
    }
  }

  void Function() _forgotPassword(BuildContext context) =>
      () => ForgotModalSheet.view(context, widget._emailController.text);

  void Function() _toRegister(BuildContext context) =>
      () => context.read<SignInCubit>().to(SingRegisterState());

  @override
  Widget build(BuildContext context) {
    final size = ThemeCore.of(context).padding;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Войти в аккаунт',
          style: ThemeCore.of(context).typography.h4,
        ),
        SizedBox(height: size.xl2),
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) => FFormBuilder<LoginForm>(
            form: _form,
            builder: (context, form) => Column(
              children: [
                TextFieldWidget(
                  controller: widget._emailController,
                  hintText: 'Email',
                  errorText: getFieldException(
                    form,
                    form.email,
                  ),
                  enabled: state is! LoginLoading,
                ),
                SizedBox(height: ThemeCore.of(context).padding.l),
                PasswordFieldWidget(
                  hideIcon: const Icon(Icons.access_time),
                  showIcon: const Icon(Icons.access_time),
                  controller: widget._passwordController,
                  hintText: 'Пароль',
                  errorText: getFieldException(
                    form,
                    form.password,
                  ),
                  enabled: state is! LoginLoading,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: size.ms),
        Align(
          alignment: Alignment.centerRight,
          child: Text.rich(
            TextSpan(
                text: 'Забыли пароль?',
                recognizer: TapGestureRecognizer()
                  ..onTap = _forgotPassword(context)),
            style: ThemeCore.of(context).typography.paragraphSmall.copyWith(
                  color: ThemeCore.of(context).color.scheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        SizedBox(height: size.xl2),
        BlocConsumer<LoginBloc, LoginState>(
          listener: _listener,
          builder: (context, state) {
            if (state is LoginLoading) {
              return const ButtonWidget(
                size: ButtonSize.l,
                isLoading: true,
              );
            }
            return ButtonWidget(
              size: ButtonSize.l,
              onPressed: _loginUser(context),
              child: const Text('Войти'),
            );
          },
        ),
        SizedBox(height: size.xl2),
        Align(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Нет аккаунта?',
                ),
                TextSpan(
                  text: ' Зарегистрируйся',
                  style: TextStyle(
                    color: ThemeCore.of(context).color.scheme.main,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _toRegister(context),
                ),
              ],
            ),
            style: ThemeCore.of(context).typography.paragraphSmall.copyWith(
                  color: ThemeCore.of(context).color.scheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }
}
