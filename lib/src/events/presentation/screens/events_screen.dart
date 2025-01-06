// 🐦 Flutter imports:
import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/current_location/presentation/widgets/location_button.dart';
import 'package:dvizh_mob/src/events/presentation/screens/event_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/bloc/categories_bloc/categories_bloc.dart';
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/category/widgets/carousel_categories.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_card.dart';
import 'package:dvizh_mob/src/shared/widgets/app_container.dart';
import 'package:dvizh_mob/src/shared/widgets/media_query_scope.dart';
import 'package:toptom_widgetbook/kit/theme_new/theme_core.dart';

class EventsScreen extends StatefulWidget implements WrappedRoute {
  const EventsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final container = DependencyProvider.of<RootDependencyContainer>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsBloc>(
          create: (context) => EventsBloc(
            container.eventRepository,
          ),
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) => CategoriesBloc(
            container.categoryRepository,
          ),
        ),
      ],
      child: this,
    );
  }

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  EventIndexParams params = EventIndexParams();

  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(FetchEventsEvent(params: params));
    context.read<CategoriesBloc>().add(CategoriesFetchEvent());
  }

  VoidCallback _toEventDetails(BuildContext context, EventModel event) => () {
        EventScreen(
          id: event.id,
        ).view(context);
      };

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'DVIZH',
      ),
      titleTextStyle: ThemeCore.of(context).typography.h3.copyWith(
        color: Colors.black,
      ),
      titleSpacing: 0,
      actions: [
        LocationButton(),
      ],
    ),
    body: MediaQueryScope(
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
                          onPressed: _toEventDetails(context, event),
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
  );
}
