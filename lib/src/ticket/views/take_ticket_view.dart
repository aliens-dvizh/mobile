// 🐦 Flutter imports:
import 'package:dvizh_mob/src/ticket/views/ticket_day_view.dart';
import 'package:dvizh_mob/src/ticket/views/ticket_list_day_view.dart';
import 'package:flutter/material.dart';
class TakeTicketView extends StatefulWidget {
  Future<void> view(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        builder: (innerContext) => Builder(
          builder: (context) => this,
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
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: TicketListDayView(),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(6),
            ),
          ],
        ),
      );
}

