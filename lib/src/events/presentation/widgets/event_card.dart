// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:toptom_widgetbook/kit/export.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/export.dart';

class EventCard extends StatelessWidget {
  const EventCard({required this.cardData, super.key});
  final EventModel cardData;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Stack(
            children: [
              Image.network(
                'https://insider.ua/wp-content/uploads/2022/08/skriptonit-e1659511280417.jpg',
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
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.5),
                      ]),
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              cardData.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.file_download_outlined,
                            color: Colors.black12,
                            size: 16,
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cardData.description,
                        style: ThemeCore.of(context)
                            .typography
                            .paragraphSmall
                            .copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
