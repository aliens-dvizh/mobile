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
      () => context.router.push(EventRoute(id: event.id));

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) => switch (state) {
                  CategoriesInitialState() ||
                  CategoriesLoadingState() =>
                    const SliverToBoxAdapter(
                      child: CupertinoActivityIndicator(),
                    ),
                  CategoriesLoadedState(
                    :ListDataModel<CategoryModel> categories
                  )
                      when categories.list.isNotEmpty =>
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.2,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.count,
                          itemBuilder: (context, index) => CategoryCard(
                            selected: true,
                            category: categories.list[index],
                          ),
                        ),
                      ),
                    ),
                  CategoriesLoadedState() => const SliverToBoxAdapter(
                      child: Text('Нет элементов'),
                    ),
                  CategoriesExceptionState() => const SliverToBoxAdapter(
                      child: Text('Exception'),
                    ),
                },
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: BlocBuilder<EventsBloc, EventsState>(
                  builder: (context, state) => switch (state) {
                    EventsInitial() ||
                    EventsLoading() =>
                      const SliverToBoxAdapter(
                        child: CupertinoActivityIndicator(),
                      ),
                    EventsLoaded(:ListDataModel<EventModel> events)
                        when events.list.isNotEmpty =>
                      SliverList.builder(
                        itemCount: events.count,
                        itemBuilder: (context, index) => EventCard(
                          event: events.list[index],
                          onPressed: _toEventDetails(events.list[index]),
                        ),
                      ),
                    EventsError() => const SliverToBoxAdapter(
                        child: Text('Exception'),
                      ),
                    EventsLoaded() => const SliverToBoxAdapter(
                        child: Text('Нет элементов'),
                      ),
                  },
                ),
              )
            ],
          ),
        ),
      );
}
