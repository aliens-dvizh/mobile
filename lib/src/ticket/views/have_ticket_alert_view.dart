import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HaveTicketAlertView extends StatelessWidget {
  const HaveTicketAlertView({super.key, required this.ticketId});

  final int ticketId;

  Future<void> view(BuildContext context) {
   return showDialog(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  VoidCallback _back(BuildContext context) => () {
    context.pop();
  };

  VoidCallback _toTicket(BuildContext context) => () {
    Navigator.of(context).popUntil((route) => route.isFirst);
    context.push('/ticket/$ticketId');
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('У вас уже есть билет, хотите перейти к нему?', style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800
          ),),
          SizedBox(height: 12,),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _back(context),
                  child: Text('Назад'),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: ElevatedButton(
                  onPressed: _toTicket(context),
                  child: Text('Перейти'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}