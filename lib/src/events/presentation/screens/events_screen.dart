// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/bloc/categories_bloc/categories_bloc.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/category/widgets/carousel_categories.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/core/router/auto_route.gr.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_card.dart';
import 'package:dvizh_mob/src/shared/widgets/app_container.dart';
import 'package:dvizh_mob/src/shared/widgets/media_query_scope.dart';

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
          child: MediaQueryScope(
            builder: (context, type) => AppContainer(
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
                          child: CarouselCategories(categories: categories),
                        ),
                      CategoriesExceptionState() => const SliverToBoxAdapter(
                          child: Text('Exception'),
                        ),
                      CategoriesLoadedState() => throw UnimplementedError(),
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16,
                    ),
                  ),
                  BlocBuilder<EventsBloc, EventsState>(
                    builder: (context, state) => switch (state) {
                      EventsInitial() ||
                      EventsLoading() =>
                        const SliverToBoxAdapter(
                          child: CupertinoActivityIndicator(),
                        ),
                      EventsLoaded(:ListDataModel<EventModel> events)
                          when events.list.isNotEmpty =>
                        SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: switch (type) {
                              MediaType.sm => 1,
                              MediaType.md => 2,
                              MediaType.lg => 3,
                            },
                            childAspectRatio: 16 / 9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: events.list.length,
                          itemBuilder: (context, index) {
                            final event = events.list[index];

                            return EventCard(
                              event: event,
                              onPressed: _toEventDetails(event),
                            );
                          },
                        ),
                      EventsError() => const SliverToBoxAdapter(
                          child: Text('Exception'),
                        ),
                      EventsLoaded() => const SliverToBoxAdapter(
                          child: Text('Нет элементов'),
                        ),
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
