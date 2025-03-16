// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:toptom_widgetbook/kit/export.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/shared/widgets/app_image.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.event,
    super.key,
    this.onPressed,
  });

  final EventModel event;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              Expanded(
                child: AppImage(
                  image: event.image,
                  width: double.infinity,
                ),
              ),
              Text(
                event.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
              ),
              if (event.description != null) ...[
                Text(
                  event.description ?? '',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ]
            ],
          ),
        ),
      );
}
