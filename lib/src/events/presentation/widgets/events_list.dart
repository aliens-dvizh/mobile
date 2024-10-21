import 'package:dvizh_mob/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:flutter/material.dart';

import 'event_card.dart';

class EventsList extends StatelessWidget {
  final ListDataModel<EventModel> eventsListData;

  const EventsList({required this.eventsListData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: eventsListData.list.map((event) {
        return EventCard(cardData: event);
      }).toList(),
    );
  }
}
