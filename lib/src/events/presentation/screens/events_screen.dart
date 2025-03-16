// 🐦 Flutter imports:
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/current_location/presentation/widgets/location_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/bloc/categories_bloc/categories_bloc.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_card.dart';
import 'package:dvizh_mob/src/shared/widgets/app_container.dart';
import 'package:dvizh_mob/src/shared/widgets/media_query_scope.dart';
import 'package:go_router/go_router.dart';

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
  late ValueNotifier<EventIndexParams> params;

  @override
  void initState() {
    super.initState();
    params = ValueNotifier(EventIndexParams())..addListener(_listenerParams);
    context.read<EventsBloc>().add(FetchEventsEvent(params: params.value));
    context.read<CategoriesBloc>().add(CategoriesFetchEvent());
  }

  @override
  void dispose() {
    params
      ..removeListener(_listenerParams)
      ..dispose();
    super.dispose();
  }

  void _listenerParams() {
    context.read<EventsBloc>().add(FetchEventsEvent(params: params.value));
  }

  VoidCallback _toEventDetails(BuildContext context, EventModel event) => () {
        context.push('/event/${event.id}');
      };

  Future<void> _onPressedDate() async {
    final result = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        firstDate: DateTime.now(),
        currentDate: params.value.startAt,
        disableModePicker: true,
      ),
      dialogSize: Size(300, 100),
      value: [params.value.startAt, params.value.endAt]
    );
    if (result == null) return;
    if (result.isEmpty) return;
    params.value = EventIndexParams(
      startAt: result.elementAtOrNull(0),
      endAt: result.elementAtOrNull(1),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'DVIZH',
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
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: _onPressedDate, child: Text('time'))
                      ],
                    ),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: switch (type) {
                            MediaType.sm => 1,
                            MediaType.md => 2,
                            MediaType.lg => 3,
                          },
                          childAspectRatio: 16 / 10,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
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
