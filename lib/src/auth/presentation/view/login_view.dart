import 'package:fform/fform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toptom_widgetbook/toptom_widgetbook.dart';

import '../../../../core/utils/validation_exception_parses.dart';
import '../../../forgot/export.dart';
import '../../export.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          builder: (context, state) {
            return FFormBuilder<LoginForm>(
              form: _form,
              builder: (context, LoginForm form) {
                return Column(
                  children: [
                    TextFieldWidget(
                      controller: widget._emailController,
                      hintText: 'Email',
                      errorText: ValidationExceptionParser.getFieldException(
                        form,
                        form.email,
                      ),
                      enabled: state is! LoginLoading,
                    ),
                    SizedBox(height: ThemeCore.of(context).padding.l),
                    PasswordFieldWidget(
                      hideIcon: Icon(Icons.access_time),
                      showIcon: Icon(Icons.access_time),
                      controller: widget._passwordController,
                      hintText: 'Пароль',
                      errorText: ValidationExceptionParser.getFieldException(
                        form,
                        form.password,
                      ),
                      enabled: state is! LoginLoading,
                    ),
                  ],
                );
              },
            );
          },
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
              child: Text('Войти'),
            );
          },
        ),
        SizedBox(height: size.xl2),
        Align(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
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
