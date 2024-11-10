// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:toptom_widgetbook/kit/export.dart';

class TakeTicketView extends StatefulWidget {
  static Future<void> view(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        builder: (innerContext) => Builder(
          builder: (context) => TakeTicketView(),
        ),
      );

  @override
  State<TakeTicketView> createState() => _TakeTicketViewState();
}

class _TakeTicketViewState extends State<TakeTicketView> {
  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.all(6),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: TicketDate(),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(6),
            ),
          ],
        ),
      );
}

class TicketDate extends StatelessWidget {
  void _takeDate() {}

  @override
  Widget build(BuildContext context) => SliverList.separated(
        itemBuilder: (context, index) => TicketTile(
          onPressed: _takeDate,
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: 10,
      );
}

class TicketTile extends StatelessWidget {
  const TicketTile({
    this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Text(
              '27',
              style: ThemeCore.of(context).typography.h2,
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              children: [
                Text('Пятница'),
                Text('октября'),
              ],
            ),
            const Spacer(),
            ButtonIcon(
              icon: Icons.arrow_forward_ios,
              onPressed: onPressed,
              size: ButtonIconSize.l,
            )
          ],
        ),
      );
}
