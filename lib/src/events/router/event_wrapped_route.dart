// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/events/bloc/event/event_bloc.dart';
import 'package:dvizh_mob/src/events/export.dart';

@RoutePage()
class EventWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  const EventWrappedScreen({super.key});

  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) => Dependencies(
        library: EventLibrary(
          parent: Dependencies.of<RootLibrary>(context),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<EventsBloc>(
              create: (context) => EventsBloc(
                Dependencies.of<EventLibrary>(context).eventRepository,
              ),
            ),
            BlocProvider<EventBloc>(
              create: (context) => EventBloc(
                Dependencies.of<EventLibrary>(context).eventRepository,
              ),
            ),
          ],
          child: this,
        ),
      );
}

class EventLibrary extends DependenciesLibrary<RootLibrary> {
  EventLibrary({required super.parent});

  late final EventRepository eventRepository;

  @override
  Future<void> init() async {
    eventRepository = EventRepository(
      EventDataSource(
        parent.dioService,
      ),
    );
  }
}
