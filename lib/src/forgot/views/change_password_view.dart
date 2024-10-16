import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dvizh_mob/core/utils/validation_exception_parses.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fform_flutter/fform_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';
import '../cubit/forgot_screen/forgot_screen_cubit.dart';
import '../cubit/reset_password/reset_password_cubit.dart';
import '../fform/export.dart';
import '../params/reset_password_params.dart';

class ChangePasswordModalView extends StatefulWidget {
  const ChangePasswordModalView({
    super.key,
    required this.email,
    required this.code,
  });

  final String email;
  final String code;

  @override
  State<ChangePasswordModalView> createState() =>
      _ChangePasswordModalViewState();
}

class _ChangePasswordModalViewState extends State<ChangePasswordModalView> {
  late TextEditingController firstPasswordController;
  late TextEditingController secondPasswordController;
  late ConfirmPasswordForm _form;

  Future<void> Function() changePassword(BuildContext context) => () async {
        _form.change(
          password: firstPasswordController.text,
          confirmPassword: secondPasswordController.text,
        );

        if (_form.isInvalid) return;

        await context.read<ResetPasswordCubit>().reset(
              ResetPasswordParams(
                email: widget.email,
                code: int.parse(widget.code),
                newPassword: firstPasswordController.text,
              ),
            );
      };

  _listener(BuildContext context, ResetPasswordState state) {
    if (state is ResetPasswordSuccess) {
      context.read<ForgotScreenCubit>().to(SuccessPasswordScreenState());
    }
  }

  @override
  void initState() {
    firstPasswordController = TextEditingController();
    secondPasswordController = TextEditingController();
    _form = ConfirmPasswordForm.parse(
      password: '',
      confirmPassword: '',
    );
    super.initState();
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
            Expanded(
              child: AutoSizeText(
                'Смена пароля',
                style: ThemeCore.of(context).typography.h3,
                maxLines: 1,
              ),
            ),
            const SizedBox(
              width: 10,
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
        SizedBox(height: size.xl4),
        BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: _listener,
          builder: (context, state) {
            return Column(
              children: [
                FFormBuilder(
                  form: _form,
                  builder: (context, form) {
                    return Column(
                      children: [
                        PasswordFieldWidget(
                          hintText: 'Новый пароль',
                          controller: firstPasswordController,
                          errorText:
                              ValidationExceptionParser.getFieldException(
                                  form.password),
                        ),
                        SizedBox(height: size.xl2),
                        TextFieldWidget.password(
                          hintText: 'Повторите пароль',
                          controller: secondPasswordController,
                          errorText: (state is ResetPasswordError)
                              ? state.message.tr()
                              : ValidationExceptionParser.getFieldException(
                                  form.password),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: size.xl4),
                if (state is ResetPasswordLoading)
                  const ButtonWidget(
                    color: ButtonColor.black,
                    isLoading: true,
                  )
                else
                  ButtonWidget(
                    onPressed: changePassword(context),
                    color: ButtonColor.black,
                    child: Text('Cохранить'),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
