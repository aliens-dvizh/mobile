// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:fform/fform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/utils/validation_exception_parses.dart';
import 'package:dvizh_mob/src/forgot/export.dart';

class SendToEmailView extends StatelessWidget with ValidationExceptionParser {
  SendToEmailView({
    required this.emailController,
    super.key,
  });

  final TextEditingController emailController;
  final EmailForm _form = EmailForm.parse(email: '');

  Future<void> Function() sendVerifyToEmail(BuildContext context) => () async {
        _form.change(email: emailController.text);

        if (_form.isInvalid) return;

        await context.read<ForgotPasswordCubit>().forgot(
              ForgotParams(email: emailController.text),
            );
      };

  void _listener(BuildContext context, ForgotPasswordState state) {
    switch (state) {
      case ForgotPasswordSuccess():
        {
          context.read<ForgotScreenCubit>().to(VerifyCodeScreenState());
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Забыли пароль?',
              style: ThemeCore.of(context).typography.h3,
            ),
            ButtonIcon(
              onPressed: context.router.maybePop,
              icon: Icons.arrow_back,
              size: ButtonIconSize.m,
              type: ButtonType.primary,
              color: ButtonColor.primary,
            )
          ],
        ),
        SizedBox(height: size.s),
        Text(
          'sdfsdfd',
          style: ThemeCore.of(context).typography.paragraphMedium,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: size.xl4),
        BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: _listener,
          builder: (context, state) => Column(
            children: [
              FFormBuilder(
                form: _form,
                builder: (context, form) => TextFieldWidget(
                  controller: emailController,
                  hintText: 'Email',
                  errorText: getFieldException(
                    form,
                    form.email,
                  ),
                ),
              ),
              SizedBox(height: size.l),
              if (state is ForgotPasswordLoading)
                const ButtonWidget(
                  color: ButtonColor.black,
                  isLoading: true,
                )
              else
                ButtonWidget(
                  onPressed: sendVerifyToEmail(context),
                  color: ButtonColor.black,
                  child: const Text('Отправить'),
                )
            ],
          ),
        ),
        SizedBox(height: size.l),
        ButtonWidget(
          type: ButtonType.defaultButton,
          onPressed: context.router.maybePop,
          child: Text(
            'Вернуться назад',
            style: ThemeCore.of(context).typography.label,
          ),
        ),
      ],
    );
  }
}
