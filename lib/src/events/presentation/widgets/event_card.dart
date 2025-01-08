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
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              AppImage(
                image: event.image,
                width: double.infinity,
                height: double.infinity,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(1),
                    ],
                  ),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          event.name,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      // FittedBox(
                      //   child: Text.rich(
                      //     TextSpan(
                      //       children: [
                      //         TextSpan(
                      //           text: event.description,
                      //         ),
                      //         TextSpan(
                      //           text: event.description,
                      //         ),
                      //       ],
                      //       style: ThemeCore.of(context)
                      //           .typography
                      //           .paragraphBig
                      //           .copyWith(
                      //             color: Colors.white,
                      //           ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
