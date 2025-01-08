// 🐦 Flutter imports:
import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/category/bloc/categories_bloc/categories_bloc.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/ticket/views/ticket_day_view.dart';
import 'package:dvizh_mob/src/ticket/views/ticket_list_day_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toptom_widgetbook/kit/components/buttons/button.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/bloc/event/event_bloc.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/shared/widgets/app_image.dart';
import 'package:dvizh_mob/src/ticket/views/take_ticket_view.dart';
import 'package:toptom_widgetbook/kit/export.dart';

class EventScreenParams {
  EventScreenParams({required this.id});

  factory EventScreenParams.fromMap(Map<String, String> parameters) =>
      EventScreenParams(id: int.parse(parameters['id']!));

  final int id;
}

class EventScreen extends StatefulWidget implements WrappedRoute {
  const EventScreen({
    required this.params,
    super.key,
  });

  final EventScreenParams params;

  void view(BuildContext context) => showBottomSheet(
        context: context,
        builder: wrappedRoute,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      );

  @override
  State<EventScreen> createState() => _EventScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => EventBloc(
          context.depend<RootDependencyContainer>().eventRepository,
        ),
        child: this,
      );
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(EventFetchEvent(widget.params.id));
  }

  VoidCallback _takeTicket(BuildContext context) => () => TakeTicketView().view(context);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) => switch (state) {
            EventInitialState() ||
            EventLoadingState() =>
              const CupertinoActivityIndicator(),
            EventLoadedState(:EventModel event) => Stack(
                children: [
                  AppImage(
                    image: event.image,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                    ),
                    child: const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            event.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(event.description),
                          SizedBox(
                            width: double.infinity,
                            child: ButtonWidget(
                              size: ButtonSize.xl,
                              onPressed: _takeTicket(context),
                              child: const Text('Взять билет'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            EventExceptionState() => const Text('Exception')
          },
        ),
      );
}
