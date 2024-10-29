// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:fform/fform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

// 🌎 Project imports:
import '../../../../core/utils/validation_exception_parses.dart';
import '../../export.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  final RegisterForm _form = RegisterForm.parse();

  void Function() _toLogin(BuildContext context) =>
      () => context.read<SignInCubit>().to(SignLoginState());

  Future<void> Function() _registerUser(BuildContext context) => () async {
        _form.change(
          name: _nameController.text,
          email: widget.emailController.text,
          password: widget.passwordController.text,
        );

        if (_form.isInvalid) return;

        context.read<RegistrationBloc>().add(
              Register(
                params: RegisterParams(
                  name: _nameController.text,
                  email: widget.emailController.text,
                  password: widget.passwordController.text,
                ),
              ),
            );
      };

  void _listener(BuildContext context, RegistrationState state) {
    switch (state) {
      case RegistrationSuccess():
        {
          context
              .read<SignInCubit>()
              .to(SingVerifyState(widget.emailController.text));
          break;
        }
      case RegistrationFailure() || RegistrationNetworkError():
        {
          snackBarBuilder(
              context,
              SnackBarOptions(
                  title: 'Ошибка регистрации', type: SnackBarType.error));
          break;
        }
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = ThemeCore.of(context).padding;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Регистрация',
          style: ThemeCore.of(context).typography.h4,
        ),
        SizedBox(height: size.xl2),
        BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: _listener,
          builder: (context, state) {
            return Column(
              children: [
                FFormBuilder<RegisterForm>(
                  form: _form,
                  builder: (context, RegisterForm form) {
                    return Column(
                      children: [
                        TextFieldWidget(
                          hintText: 'Имя',
                          controller: _nameController,
                          enabled: state is! RegistrationLoading,
                          errorText:
                              ValidationExceptionParser.getFieldException(
                                  form, form.name),
                        ),
                        SizedBox(height: size.l),
                        TextFieldWidget(
                          hintText: 'Email',
                          controller: widget.emailController,
                          enabled: state is! RegistrationLoading,
                          errorText:
                              ValidationExceptionParser.getFieldException(
                            form,
                            form.email,
                          ),
                        ),
                        SizedBox(height: size.l),
                        PasswordFieldWidget(
                          hideIcon: Icon(Icons.access_time),
                          showIcon: Icon(Icons.access_time),
                          hintText: 'Пароль',
                          controller: widget.passwordController,
                          enabled: state is! RegistrationLoading,
                          errorText:
                              ValidationExceptionParser.getFieldException(
                            form,
                            form.password,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: size.xl2),
                SizedBox(
                  width: double.infinity,
                  child: (state is RegistrationLoading)
                      ? const ButtonWidget(
                          size: ButtonSize.l,
                          isLoading: true,
                        )
                      : ButtonWidget(
                          size: ButtonSize.l,
                          onPressed: _registerUser(context),
                          child: Text('Зарегистрироваться'),
                        ),
                ),
              ],
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
                  text: 'Есть аккаунт? ',
                ),
                TextSpan(
                  text: ' Войти',
                  style: TextStyle(
                    color: ThemeCore.of(context).color.scheme.main,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _toLogin(context),
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
