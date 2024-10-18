import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

import '../../export.dart';

class VerificationModalView extends StatefulWidget {
  const VerificationModalView({
    super.key,
    required this.email,
    required this.codeController,
  });

  final String email;
  final TextEditingController codeController;

  @override
  State<VerificationModalView> createState() => _VerificationModalViewState();
}

class _VerificationModalViewState extends State<VerificationModalView> {
  final ValueNotifier<bool> canResendNotifier = ValueNotifier<bool>(true);

  final ValueNotifier<int> secondsRemainingNotifier = ValueNotifier<int>(60);

  Future<void> Function() _resendCode(BuildContext context) => () async {
        if (!canResendNotifier.value) return;

        if (canResendNotifier.value) {
          canResendNotifier.value = false;
          secondsRemainingNotifier.value = 60;
          Timer.periodic(const Duration(seconds: 1), (timer) {
            if (secondsRemainingNotifier.value > 0) {
              secondsRemainingNotifier.value--;
            } else {
              canResendNotifier.value = true;
              timer.cancel();
            }
          });
        }

        await context
            .read<ForgotPasswordCubit>()
            .forgot(ForgotParams(email: widget.email));
      };

  Function() _changeEmail(BuildContext context) => () {
        context.read<ForgotScreenCubit>().to(SendCodeScreenState());
      };

  Future<void> _sendVerificationCode() async {
    if (widget.codeController.value.text.length < 6) return;
    final code = int.tryParse(widget.codeController.value.text);
    if (code == null) return;
    await context.read<VerificationPasswordCubit>().sendVerificationCode(
          VerifyEmailParams(email: widget.email, code: code),
        );
  }

  void _listener(BuildContext context, VerificationPasswordState state) {
    switch (state) {
      case VerificationPasswordSuccess():
        {
          context.read<ForgotScreenCubit>().to(ResetPasswordScreenState());
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
        AutoSizeText(
          'Проверить Email',
          style: ThemeCore.of(context).typography.h3,
          maxLines: 1,
        ),
        SizedBox(height: size.s),
        Text(
          'Мы отправили его на ${widget.email}',
          style: ThemeCore.of(context).typography.paragraphMedium,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: size.s),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: _changeEmail(context),
          child: Text(
            'Аааа?',
            style: ThemeCore.of(context).typography.paragraphMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
        SizedBox(height: size.xl4),
        BlocConsumer<VerificationPasswordCubit, VerificationPasswordState>(
          listener: _listener,
          builder: (context, state) {
            return TextFieldWidget.number(
              controller: widget.codeController,
              hintText: 'Код',
              maxLength: 6,
              errorText:
                  state is VerificationPasswordError ? state.message : null,
              enabled: state is! VerificationPasswordLoading,
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: canResendNotifier,
          builder: (context, canResendValue, child) {
            if (!canResendValue) {
              return ValueListenableBuilder(
                valueListenable: secondsRemainingNotifier,
                builder: (context, secondsRemainingValue, child) => TextButton(
                  onPressed: () {},
                  child: Text(
                    'Отправить код повторно \n$secondsRemainingValue сек',
                    style: TextStyle(
                        color: ThemeCore.of(context).color.scheme.textPrimary),
                  ),
                ),
              );
            }
            return TextButton(
              onPressed: _resendCode(context),
              child: Text(
                'Отправить повторно',
                style: const TextStyle(color: Colors.black),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    widget.codeController.addListener(_sendVerificationCode);
  }

  @override
  void dispose() {
    super.dispose();
    widget.codeController.removeListener(_sendVerificationCode);
  }
}
