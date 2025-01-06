// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/forgot/export.dart';
import 'package:dvizh_mob/src/forgot/presentation/views/change_password_view.dart';
import 'package:dvizh_mob/src/forgot/presentation/views/finish_changed_view.dart';
import 'package:dvizh_mob/src/forgot/presentation/views/send_to_email_view.dart';
import 'package:dvizh_mob/src/forgot/presentation/views/verification_view.dart';

class ForgotModalSheet extends StatefulWidget {
  const ForgotModalSheet({
    required this.email,
    super.key,
  });
  final String email;

  static Future<void> view(BuildContext context, String email) async {
    final repository = ForgotRepository(
      ForgotDataSource(
        DependencyProvider.of<RootDependencyContainer>(context).dioService,
      ),
    );
    await showModalBottomSheet<void>(
      backgroundColor: Colors.transparent.withOpacity(0.06),
      isScrollControlled: true,
      context: context,
      builder: (innerContext) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ForgotPasswordCubit(repository),
          ),
          BlocProvider(
            create: (context) => ResetPasswordCubit(repository),
          ),
          BlocProvider(
            create: (context) => VerificationPasswordCubit(repository),
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
  Widget build(BuildContext context) => Padding(
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
              builder: (context, state) => switch (state) {
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
              },
            ),
          ),
        ),
      );
}
