// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/models/event_type_model.dart';

class EventType extends StatelessWidget {
  final EventTypeModel eventTypeData;
  final bool selected;

  const EventType({
    required this.selected,
    required this.eventTypeData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.2;
    return GestureDetector(
      onTap: () {
        print('Some action');
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.black : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            width: size,
            height: size,
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
                AutoSizeText(
                  eventTypeData.eventTypeName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
