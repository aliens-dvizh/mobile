import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_card.dart';
import 'package:dvizh_mob/src/favorite/controllers/favorite_events_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoriteScreen extends StatelessWidget {
  VoidCallback _toEventDetails(BuildContext context, EventModel event) => () {
        context.push('/event/${event.id}');
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Избранное'),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: BlocBuilder<FavoriteEventsCubit, FavoriteEventsState>(
              builder: (context, state) => switch (state) {
                FavoriteEventsInitialState() ||
                FavoriteEventsLoadingState() =>
                  const SliverToBoxAdapter(
                    child: CupertinoActivityIndicator(),
                  ),
                FavoriteEventsLoadedState(:List<EventModel> events)
                    when events.isNotEmpty =>
                  SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 16 / 10,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return EventCard(
                        event: event,
                        onPressed: _toEventDetails(context, event),
                      );
                    },
                  ),
                FavoriteEventsExceptionState() => const SliverToBoxAdapter(
                    child: Text('Exception'),
                  ),
                FavoriteEventsLoadedState() => const SliverToBoxAdapter(
                    child: Text('Нет элементов'),
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
