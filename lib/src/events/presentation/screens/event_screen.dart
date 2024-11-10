// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/bloc/event/event_bloc.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/shared/widgets/app_image.dart';

@RoutePage()
class EventScreen extends StatelessWidget {
  const EventScreen({
    @PathParam('id') required this.id,
    super.key,
  });

  final int id;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<EventBloc, EventState>(
              builder: (context, state) => switch (state) {
                EventInitialState() ||
                EventLoadingState() =>
                  const CupertinoActivityIndicator(),
                EventLoadedState(:EventModel event) => Stack(
                    children: [
                      AppImage(
                        image: event.image,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(event.name),
                            Text(event.description),
                          ],
                        ),
                      )
                    ],
                  ),
                EventExceptionState() => const Text('Exception')
              },
            ),
          ),
        ),
      );
}
