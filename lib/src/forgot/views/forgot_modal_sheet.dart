import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/forgot/repository/forgot_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/reset_password/reset_password_cubit.dart';
import '../cubit/verification_password/verification_password_cubit.dart';
import '../cubit/forgot_screen/forgot_screen_cubit.dart';
import 'change_password_view.dart';
import 'finish_changed_view.dart';
import 'send_to_email_view.dart';
import 'verification_view.dart';

class ForgotModalSheet extends StatefulWidget {
  final String email;
  const ForgotModalSheet({
    super.key,
    required this.email,
  });

  static Future<void> view(BuildContext context, String email) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent.withOpacity(0.06),
      isScrollControlled: true,
      context: context,
      builder: (innerContext) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ForgotPasswordCubit(
              Dependencies.of(context).get<ForgotRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ResetPasswordCubit(
              Dependencies.of(context).get<ForgotRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => VerificationPasswordCubit(
              Dependencies.of(context).get<ForgotRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ForgotScreenCubit(),
          ),
        ],
        child: ForgotModalSheet(
          email: email,
        ),
      ),
    );
  }

  @override
  State<ForgotModalSheet> createState() => _ForgotModalSheetState();
}

class _ForgotModalSheetState extends State<ForgotModalSheet> {
  late TextEditingController emailController;

  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    codeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ThemeCore.of(context).color.scheme.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(ThemeCore.of(context).padding.xl),
          child: BlocBuilder<ForgotScreenCubit, ForgotScreenState>(
            builder: (context, state) {
              return switch (state) {
                SendCodeScreenState() => SendToEmailView(
                    emailController: emailController,
                  ),
                VerifyCodeScreenState() => VerificationModalView(
                    email: emailController.value.text,
                    codeController: codeController,
                  ),
                ResetPasswordScreenState() => ChangePasswordModalView(
                    email: emailController.text,
                    code: codeController.text,
                  ),
                SuccessPasswordScreenState() => const FinishChangedModal(),
              };
            },
          ),
        ),
      ),
    );
  }
}