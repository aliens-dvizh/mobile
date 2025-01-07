import 'package:dvizh_mob/src/ticket/widgets/ticket_tile_widget.dart';
import 'package:flutter/material.dart';

class TicketListDayView extends StatelessWidget {
  void _takeDate() {}

  @override
  Widget build(BuildContext context) => SliverList.separated(
    itemBuilder: (context, index) => TicketTileWidget(
      onPressed: _takeDate,
    ),
    separatorBuilder: (context, index) => const Divider(),
    itemCount: 10,
  );
}
