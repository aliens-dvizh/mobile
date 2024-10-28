import 'package:dvizh_mob/src/events/models/event_type_model.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_type.dart';
import 'package:flutter/material.dart';

class EventsTypeList extends StatelessWidget {
  const EventsTypeList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            EventType(
              selected: true,
              eventTypeData: EventTypeModel(
                  eventTypeIcon: Icons.theater_comedy, eventTypeName: 'Театр'),
            ),
            SizedBox(
              width: 10,
            ),
            EventType(
              selected: false,
              eventTypeData: EventTypeModel(
                  eventTypeIcon: Icons.mic_none_rounded,
                  eventTypeName: 'Радио'),
            ),
            SizedBox(
              width: 10,
            ),
            EventType(
              selected: false,
              eventTypeData: EventTypeModel(
                  eventTypeIcon: Icons.car_crash, eventTypeName: 'Гонки'),
            ),
            SizedBox(
              width: 10,
            ),
            EventType(
              selected: false,
              eventTypeData: EventTypeModel(
                  eventTypeIcon: Icons.airplanemode_active,
                  eventTypeName: 'Полеты'),
            ),
            SizedBox(
              width: 10,
            ),
            EventType(
              selected: false,
              eventTypeData: EventTypeModel(
                  eventTypeIcon: Icons.directions_run, eventTypeName: 'Бег'),
            ),
            SizedBox(
              width: 10,
            ),
            EventType(
              selected: false,
              eventTypeData: EventTypeModel(
                  eventTypeIcon: Icons.beach_access, eventTypeName: 'Пляж'),
            ),
          ],
        ),
      ),
    );
  }
}
