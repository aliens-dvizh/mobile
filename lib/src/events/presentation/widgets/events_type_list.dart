// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/models/event_type_model.dart';
import 'package:dvizh_mob/src/events/presentation/widgets/event_type.dart';

class EventsTypeList extends StatelessWidget {
  const EventsTypeList({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              EventType(
                selected: true,
                eventTypeData: EventTypeModel(
                    eventTypeIcon: Icons.theater_comedy,
                    eventTypeName: 'Театр'),
              ),
              const SizedBox(
                width: 10,
              ),
              EventType(
                selected: false,
                eventTypeData: EventTypeModel(
                    eventTypeIcon: Icons.mic_none_rounded,
                    eventTypeName: 'Радио'),
              ),
              const SizedBox(
                width: 10,
              ),
              EventType(
                selected: false,
                eventTypeData: EventTypeModel(
                    eventTypeIcon: Icons.car_crash, eventTypeName: 'Гонки'),
              ),
              const SizedBox(
                width: 10,
              ),
              EventType(
                selected: false,
                eventTypeData: EventTypeModel(
                    eventTypeIcon: Icons.airplanemode_active,
                    eventTypeName: 'Полеты'),
              ),
              const SizedBox(
                width: 10,
              ),
              EventType(
                selected: false,
                eventTypeData: EventTypeModel(
                    eventTypeIcon: Icons.directions_run, eventTypeName: 'Бег'),
              ),
              const SizedBox(
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
