import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';
import '../bloc/export.dart';
import '../params/export.dart';

const int secondsRemaining = 60;
const int codeLength = 6;

class VerifyView extends StatefulWidget {
  const VerifyView({super.key, required this.email});

  final String email;

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  late TextEditingController codeController;
  late StreamController<ErrorAnimationType> errorController;
  bool canResend = true;
  ValueNotifier<bool> canResendNotifier = ValueNotifier<bool>(true);
  ValueNotifier<int> secondsRemainingNotifier =
      ValueNotifier<int>(secondsRemaining);

  @override
  void initState() {
    codeController = TextEditingController()..addListener(_listenerCode);
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    codeController
      ..removeListener(_listenerCode)
      ..dispose();
    errorController.close();
    super.dispose();
  }

  void _listenerCode() {
    if (codeController.text.trim().length == codeLength) {
      _verify();
    }
  }

  Future<void> _verify() async {
    context.read<VerifyBloc>().add(
          VerifyFetch(
            VerifyParams(
              email: widget.email,
              code: codeController.text.trim(),
            ),
          ),
        );
  }

  Future<void> Function() _resendCode(BuildContext context) => () async {
        if (!canResendNotifier.value) return;

        _timeout();
        context.read<VerifyBloc>().add(ResendVerificationCode(widget.email));
      };

  void _timeout() {
    if (canResendNotifier.value) {
      canResendNotifier.value = false;
      secondsRemainingNotifier.value = secondsRemaining;

      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (secondsRemainingNotifier.value > 0) {
          secondsRemainingNotifier.value--;
        } else {
          canResendNotifier.value = true;
          timer.cancel();
        }
      });
    }
  }

  void _listener(BuildContext context, VerifyState state) {
    switch (state) {
      case VerifySuccess():
        {
          context.router.maybePop();
          break;
        }
      case VerifyError():
        {
          snackBarBuilder(
              context,
              SnackBarOptions(
                  title: 'Ошибка верификации', type: SnackBarType.error));
          errorController.add(ErrorAnimationType.shake);
          break;
        }
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = ThemeCore.of(context).padding;
    return CardWidget(
      padding: EdgeInsets.all(size.xl2),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Верификация',
          style: ThemeCore.of(context).typography.h4,
        ),
        SizedBox(height: size.m),
        Text(
          'Получите код верификации',
          style: ThemeCore.of(context).typography.paragraphMedium,
        ),
        SizedBox(height: size.xl2),
        BlocConsumer<VerifyBloc, VerifyState>(
          listener: _listener,
          builder: (context, state) {
            return ToptomPincodeField(
              length: codeLength,
              errorController: errorController,
              controller: codeController,
              enabled: state is! VerifyLoading,
            );
          },
        ),
        SizedBox(height: size.xl2),
        ValueListenableBuilder(
          valueListenable: canResendNotifier,
          builder: (context, canResendValue, child) {
            return ValueListenableBuilder(
              valueListenable: secondsRemainingNotifier,
              builder: (context, secondsRemainingValue, child) {
                return Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: ThemeCore.of(context)
                        .typography
                        .paragraphSmall
                        .copyWith(
                          color:
                              ThemeCore.of(context).color.scheme.textSecondary,
                        ),
                    children: [
                      if (canResendValue)
                        TextSpan(
                          text: '${'Отправить код повторно'}\n',
                          recognizer: TapGestureRecognizer()
                            ..onTap = _resendCode(context),
                          style: TextStyle(
                            color: ThemeCore.of(context).color.scheme.main,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      else
                        TextSpan(
                          text:
                              '${'Вы можете отправить повтрно через'} $secondsRemainingValue ${'секунд'}',
                          style: TextStyle(
                            color: canResendValue
                                ? ThemeCore.of(context).color.scheme.main
                                : Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
