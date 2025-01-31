import 'package:dvizh_mob/src/auth/bloc/auth/auth_bloc.dart';
import 'package:dvizh_mob/src/ticket/views/ticket_day_view.dart';
import 'package:dvizh_mob/src/ticket/widgets/ticket_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TicketListDayView extends StatefulWidget {
  @override
  State<TicketListDayView> createState() => _TicketListDayViewState();
}

class _TicketListDayViewState extends State<TicketListDayView> {
  void _takeDate() {
    final authState = context.read<AuthBloc>().state;
    if(authState is! AuthIsSign) {
      context.push('/auth');
    } else {

    }

  }



  @override
  Widget build(BuildContext context) => SliverList.separated(
    itemBuilder: (context, index) => TicketTileWidget(
      onPressed: _takeDate,
    ),
    separatorBuilder: (context, index) => const Divider(),
    itemCount: 10,
  );
}
