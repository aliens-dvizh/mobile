// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/events/bloc/event/event_bloc.dart';
import 'package:dvizh_mob/src/events/dependency/event_dependency.dart';
import 'package:dvizh_mob/src/events/dependency/event_dependency_factory.dart';
import 'package:dvizh_mob/src/events/export.dart';

@RoutePage()
class EventWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  const EventWrappedScreen({super.key});

  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) =>
      DependencyScope<EventDependency, EventDependencyFactory>(
        factory: EventDependencyFactory(
          useMocks:
              DependencyProvider.of<RootLibrary>(context).settings.useMocks,
          dioService: DependencyProvider.of<RootLibrary>(context).dioService,
        ),
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<EventsBloc>(
              create: (context) => EventsBloc(
                DependencyProvider.of<EventDependency>(context).eventRepository,
              ),
            ),
            BlocProvider<EventBloc>(
              create: (context) => EventBloc(
                DependencyProvider.of<EventDependency>(context).eventRepository,
              ),
            ),
          ],
          child: this,
        ),
      );
}
