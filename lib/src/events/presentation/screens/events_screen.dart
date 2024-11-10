// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/bloc/categories_bloc/categories_bloc.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/category/widgets/category_card.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/core/router/auto_route.gr.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_card.dart';

@RoutePage()
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  EventIndexParams params = EventIndexParams();

  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(FetchEventsEvent(params: params));
  }

  VoidCallback _toEventDetails(EventModel event) =>
      () => context.router.navigate(EventRoute(id: event.id));

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Builder(
              builder: (context) {
                final eventsState = context.watch<EventsBloc>().state;
                final categoryState = context.watch<CategoriesBloc>().state;

                return Column(
                  children: [
                    switch (categoryState) {
                      CategoriesInitialState() ||
                      CategoriesLoadingState() =>
                        const CupertinoActivityIndicator(),
                      CategoriesLoadedState(
                        :ListDataModel<CategoryModel> categories
                      )
                          when categories.list.isNotEmpty =>
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categories.list
                                .map(
                                  (category) => Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CategoryCard(
                                        selected: category.id == 1,
                                        category: category),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      CategoriesLoadedState() => const Text('Нет предметов'),
                      CategoriesExceptionState() => const Text('exception'),
                    },
                    const SizedBox(
                      height: 10,
                    ),
                    switch (eventsState) {
                      EventsInitial() ||
                      EventsLoading() =>
                        const CupertinoActivityIndicator(),
                      EventsLoaded(:ListDataModel<EventModel> events)
                          when events.list.isNotEmpty =>
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: events.count,
                          itemBuilder: (context, index) => EventCard(
                            event: events.list[index],
                            onPressed: _toEventDetails(events.list[index]),
                          ),
                        ),
                      EventsLoaded() => const Text('Нет элементов'),
                      EventsError() => const Text('Exception'),
                    },
                  ],
                );
              },
            ),
          ),
        ),
      );
}
