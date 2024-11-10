// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/models/event_type_model.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_card.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_type.dart';

@RoutePage()
class EventsScreen extends StatefulWidget implements AutoRouteWrapper {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => EventsBloc(
          Dependencies.of<RootLibrary>(context).eventRepository,
        ),
        child: this,
      );
}

class _EventsScreenState extends State<EventsScreen> {
  EventIndexParams params = EventIndexParams();

  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(FetchEventsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Builder(builder: (context) {
              final eventsState = context.watch<EventsBloc>().state;
              return Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) => Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CategoryCard(
                          selected: index % 2 == 0,
                          category: CategoryModel(
                            icon: Icons.beach_access,
                            name: 'Пляж',
                          ),
                        ),
                      ),)
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  switch (eventsState) {
                    EventsInitial() ||
                    EventsLoading() =>
                      const CupertinoActivityIndicator(),
                    EventsLoaded(events: ListDataModel<EventModel> events)
                        when events.list.isNotEmpty =>
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: events.count,
                        itemBuilder: (context, index) => EventCard(
                          event: EventModel(
                            id: 1,
                            description:
                                '7, 8, 9 октября • Первомайские пруды • мест 2',
                            name: 'Skriptonit',
                          ),
                        ),
                      ),
                    EventsLoaded() => const Text('Нет элементов'),
                    EventsError() => const Text('Exception'),
                  },
                ],
              );
            }),
          ),
        ),
      );
}
