// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/events_list.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/events_type_list.dart';
import '../../export.dart';
import '../widgets/event_card.dart';

@RoutePage()
class EventsScreen extends StatefulWidget implements AutoRouteWrapper {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc(
        Dependencies.of<RootLibrary>(context).eventRepository,
      ),
      child: this,
    );
  }
}

class _EventsScreenState extends State<EventsScreen> {
  EventIndexParams params = EventIndexParams();

  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(FetchEventsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мероприятия'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Events Screen'),
              EventsTypeList(),
              SizedBox(
                height: 10,
              ),
              ...List.generate(5, (value) {
                return EventCard(
                  cardData: EventModel(
                    id: 1,
                    description:
                        '7, 8, 9 октября • Первомайские пруды • мест 2',
                    name: 'Skriptonit',
                  ),
                );
              }),
              BlocBuilder<EventsBloc, EventsState>(
                builder: (context, state) {
                  return switch (state) {
                    EventsInitial() ||
                    EventsLoading() =>
                      CupertinoActivityIndicator(),
                    EventsLoaded(events: ListDataModel<EventModel> events)
                        when (events.list.isNotEmpty) =>
                      EventsList(
                        eventsListData: events,
                      ),
                    EventsLoaded() => Text('Нет элементов'),
                    EventsError() => Text('Exception'),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
