// 🐦 Flutter imports:
import 'package:dvizh_mob/src/favorite/views/favorite_event_button.dart';
import 'package:easy_localization/easy_localization.dart';
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
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AppImage(
                        image: event.images.firstOrNull?.url,
                        width: double.infinity,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FavoriteEventButtonView(
                        eventId: event.id,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: DateFormat('MMMM, dd')
                          .format(event.holdedAt ?? DateTime.now()),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: 5,
                        height: 5,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                    TextSpan(
                      text: event.category?.name,
                    ),
                  ],
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
            ],
          ),
        ),
      );
}
