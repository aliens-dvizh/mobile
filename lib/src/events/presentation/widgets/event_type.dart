import 'package:auto_size_text/auto_size_text.dart';
import 'package:dvizh_mob/src/events/models/event_type_model.dart';
import 'package:flutter/material.dart';

class EventType extends StatelessWidget {
  final EventTypeModel eventTypeData;
  final bool selected;

  const EventType(
      {required this.selected, required this.eventTypeData, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Some action');
      },
      child: Container(
        width: 90,
        height: 90,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
              color: selected ? Colors.black : Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              eventTypeData.eventTypeIcon,
              size: 35,
              color: selected ? Colors.black : Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            AutoSizeText(eventTypeData.eventTypeName,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.black : Colors.grey)),
          ],
        ),
      ),
    );
  }
}
