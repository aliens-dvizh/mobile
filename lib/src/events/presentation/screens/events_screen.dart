import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:dvizh_mob/core/models/list_data/list_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../export.dart';

@RoutePage()
class EventsScreen extends StatefulWidget implements AutoRouteWrapper {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            EventsBloc(Dependencies.of(context).get<EventRepository>()),
        child: this);
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Events Screen'),
              BlocBuilder<EventsBloc, EventsState>(
                builder: (context, state) {
                  return switch (state) {
                    EventsInitial() ||
                    EventsLoading() =>
                      CupertinoActivityIndicator(),
                    EventsLoaded(events: ListDataModel<EventModel> events) =>
                      Column(
                        children: events.list.map((event) {
                          return Text(event.name);
                        }).toList(),
                      ),
                    EventsError() => Text('Exception')
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
