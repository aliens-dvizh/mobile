// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/kit/components/buttons/button.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/bloc/event/event_bloc.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/shared/widgets/app_image.dart';
import 'package:dvizh_mob/src/ticket/views/take_ticket_view.dart';

@RoutePage()
class EventScreen extends StatefulWidget {
  const EventScreen({
    @PathParam('id') required this.id,
    super.key,
  });

  final int id;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  void _takeTicket() => TakeTicketView.view(context);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<EventBloc, EventState>(
              builder: (context, state) => switch (state) {
                EventInitialState() ||
                EventLoadingState() =>
                  const CupertinoActivityIndicator(),
                EventLoadedState(:EventModel event) => Stack(
                    children: [
                      AppImage(
                        image: event.image,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(event.name),
                            Text(event.description),
                          ],
                        ),
                      ),
                      ButtonWidget(
                        onPressed: _takeTicket,
                        child: const Text('Take Ticket'),
                      )
                    ],
                  ),
                EventExceptionState() => const Text('Exception')
              },
            ),
          ),
        ),
      );
}
