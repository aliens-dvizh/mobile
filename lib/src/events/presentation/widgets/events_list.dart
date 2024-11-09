// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_card.dart';

class EventsList extends StatelessWidget {
  const EventsList({required this.eventsListData, super.key});
  final ListDataModel<EventModel> eventsListData;

  @override
  Widget build(BuildContext context) => Column(
        children: eventsListData.list
            .map((event) => EventCard(cardData: event))
            .toList(),
      );
}
