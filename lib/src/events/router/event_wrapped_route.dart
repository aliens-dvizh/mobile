// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/events/bloc/event/event_bloc.dart';
import 'package:dvizh_mob/src/events/dependency/event_dependency.dart';
import 'package:dvizh_mob/src/events/dependency/ievent_dependency.dart';
import 'package:dvizh_mob/src/events/dependency/mock_dependency.dart';
import 'package:dvizh_mob/src/events/export.dart';

@RoutePage()
class EventWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  const EventWrappedScreen({super.key});

  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) =>
      DependencyScope<IEventDependency>(
        dependency: kDebugMode
            ? MockEventDependency(
                parent: DependencyProvider.of<RootLibrary>(context))
            : EventLibrary(
                parent: DependencyProvider.of<RootLibrary>(context),
              ),
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<EventsBloc>(
              create: (context) => EventsBloc(
                DependencyProvider.of<IEventDependency>(context)
                    .eventRepository,
              ),
            ),
            BlocProvider<EventBloc>(
              create: (context) => EventBloc(
                DependencyProvider.of<IEventDependency>(context)
                    .eventRepository,
              ),
            ),
          ],
          child: this,
        ),
      );
}
