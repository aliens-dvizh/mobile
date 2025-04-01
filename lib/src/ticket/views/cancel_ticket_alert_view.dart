import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/ticket/controllers/cancel/cancel_ticket_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CancelTicketAlertView extends StatelessWidget {
  const CancelTicketAlertView({super.key, required this.ticketId});

  final int ticketId;

  Future<void> view(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => CancelTicketCubit(
              context.depend<RootDependencyContainer>().tickerRepository
          ),
          child: this,
        );
      },
    );

  VoidCallback _back(BuildContext context) =>
          () {
        context.pop();
      };

  VoidCallback _cancel(BuildContext context) =>
          () {
        context.read<CancelTicketCubit>().cancel(ticketId);
      };

  void _listener(BuildContext context, CancelTicketState state) {
    if(state case CancelTicketLoadedState state) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Вы уверены, что хотите отменить билет?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _back(context),
                  child: Text('Назад'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: BlocConsumer<CancelTicketCubit, CancelTicketState>(
                  listener: _listener,
                  builder: (context, state) {
                    return switch(state) {
                      CancelTicketInitialState() || CancelTicketLoadedState() || CancelTicketExceptionState() => ElevatedButton(
                        onPressed: _cancel(context),
                        child: Text('Отменить'),
                      ),
                      CancelTicketLoadingState() => ElevatedButton(
                        onPressed: () {},
                        child: CupertinoActivityIndicator(),
                      ),
                    };
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
