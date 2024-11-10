// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:toptom_widgetbook/kit/export.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/export.dart';

class EventCard extends StatelessWidget {
  const EventCard({required this.event, super.key});

  final EventModel event;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.network(
                  event.image ?? '',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, url, progress) {
                    if (progress == null) {
                      return url;
                    }
                    return const CupertinoActivityIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
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
                            style: ThemeCore.of(context)
                                .typography
                                .paragraphBig
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: event.description,
                                ),
                              ],
                              style: ThemeCore.of(context)
                                  .typography
                                  .paragraphBig
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
