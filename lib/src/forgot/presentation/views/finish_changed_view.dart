// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

class FinishChangedModal extends StatelessWidget {
  const FinishChangedModal({super.key});

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
                'Пароль изменён',
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
        SizedBox(height: size.xl3),
        const Center(child: Icon(Icons.access_time)),
        SizedBox(height: size.xl3),
        Text(
          'Что?',
          style: ThemeCore.of(context).typography.paragraphMedium,
        ),
        SizedBox(height: size.xl3),
        ButtonWidget(
          onPressed: context.router.maybePop,
          color: ButtonColor.black,
          child: const Text('Вернуться'),
        ),
      ],
    );
  }
}
