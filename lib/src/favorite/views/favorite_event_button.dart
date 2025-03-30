import 'package:dvizh_mob/src/favorite/controllers/favorite_events_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

class FavoriteEventButtonView extends StatelessWidget {
  const FavoriteEventButtonView({
    required this.eventId,
    this.color,
    super.key,
  });

  final int eventId;
  final Color? color;

  VoidCallback onPressed(BuildContext context) => ()  {
    context.read<FavoriteEventsCubit>().toggle(eventId);
  };

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: onPressed(context),
      icon: BlocBuilder<FavoriteEventsCubit, FavoriteEventsState>(
        builder: (context, state) {
          bool isSelected = switch(state) {
            FavoriteEventsLoadedState state => state.events.firstWhereOrNull((event) => event.id == eventId) != null,
            _ => false,
          };
          return Icon(
            isSelected ? Icons.favorite : Icons.favorite_border,
            color: color,
          );
        }
      ),
    );
}
