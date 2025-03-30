import 'package:dvizh_mob/src/events/presentation/widgets/event_card.dart';
import 'package:dvizh_mob/src/ticket/controllers/tickers/tickers_cubit.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';
import 'package:dvizh_mob/src/ticket/widgets/ticket_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TicketsScreen extends StatefulWidget {
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TicketsCubit>().fetch();
  }

  VoidCallback onPressedOnCard(TicketModel ticket) => () {
    context.push('/ticket/${ticket.id}');
  };

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              title: Text('Мои билеты'),
            ),
            BlocBuilder<TicketsCubit, TicketsState>(
              builder: (context, state) => switch (state) {
                TickersInitialState() ||
                TickersLoadingState() =>
                  SliverToBoxAdapter(
                    child: CupertinoActivityIndicator(),
                  ),
                TickersLoadedState state => SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverList.builder(
                      itemBuilder: (context, index) {
                        final ticket = state.tickets[index];
                        return TicketCard(
                          ticket: ticket,
                          onPressed: onPressedOnCard(ticket),
                        );
                      },
                      itemCount: state.tickets.length,
                    ),
                  ),
                TickersExceptionState() => SliverToBoxAdapter(
                    child: Text('Exception'),
                  ),
              },
            ),
          ],
        ),
      );
}
