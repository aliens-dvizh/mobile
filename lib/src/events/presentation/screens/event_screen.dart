import 'package:carousel_slider/carousel_slider.dart';
import 'package:depend/depend.dart';
import 'package:dvizh_mob/generated/assets.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/favorite/views/favorite_event_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dvizh_mob/src/events/bloc/event/event_bloc.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/shared/widgets/app_image.dart';
import 'package:dvizh_mob/src/ticket/views/take_ticket_view.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toptom_widgetbook/kit/export.dart';
import 'package:url_launcher/url_launcher.dart';

class EventScreenParams {
  EventScreenParams({required this.id});

  factory EventScreenParams.fromMap(Map<String, String> parameters) =>
      EventScreenParams(id: int.parse(parameters['id']!));

  final int id;
}

class EventScreen extends StatefulWidget implements WrappedRoute {
  const EventScreen({
    required this.params,
    super.key,
  });

  final EventScreenParams params;

  void view(BuildContext context) => showBottomSheet(
        context: context,
        builder: wrappedRoute,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      );

  @override
  State<EventScreen> createState() => _EventScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => this;
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(EventFetchEvent(widget.params.id));
  }

  VoidCallback _takeTicket(BuildContext context) => () {
        context.push('/ticket/create/${widget.params.id}');
      };

  void _favorite() {}

  void _share() async {
    final result = await Share.share(
        'check out my website https://dvizh.com/event/${widget.params.id}');
  }

  VoidCallback _place(BuildContext context, PlaceModel place) => () async {
        final application2gdis =
            'dgis://2gis.ru/routeSearch/rsType/car/to/${place.lat},${place.lon}';
        final applicationYandex =
            'yandexnavi://build_route_on_map?lat_to=${place.lat}&lon_to=${place.lon}';
        final uridgis = Uri.parse(application2gdis);
        final uriYandex = Uri.parse(applicationYandex);

        if (await canLaunchUrl(uridgis)) {
          await launchUrl(uridgis);
        } else if (await canLaunchUrl(uriYandex)) {
          await launchUrl(uriYandex);
        }
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    actions: [
                      FavoriteEventButtonView(
                        eventId: widget.params.id,
                      ),
                      IconButton(
                        onPressed: _share,
                        icon: Icon(
                          Icons.share,
                        ),
                      )
                    ],
                  ),
                  BlocBuilder<EventBloc, EventState>(
                    builder: (context, state) => SliverList.list(
                      children: [
                        ...switch (state) {
                          EventInitialState() || EventLoadingState() => [
                              const CupertinoActivityIndicator(),
                            ],
                          EventLoadedState(:EventModel event) => [
                              CarouselSlider(
                                options: CarouselOptions(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.2,
                                  viewportFraction: 0.9,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.2,
                                ),
                                items: event.images
                                    .map(
                                      (image) => AppImage(
                                        image: image.url,
                                        width: double.infinity,
                                      ),
                                    )
                                    .toList(),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (event.category != null) ...[
                                        Text(
                                          event.category?.name ?? '',
                                          style: TextStyle(
                                            color: Colors.black.withAlpha(150),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                      Text(
                                        event.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      if (event.holdedAt != null) ...[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          spacing: 12,
                                          children: [
                                            Icon(Icons.calendar_month),
                                            Text(DateFormat('MMMM, d')
                                                .format(event.holdedAt!))
                                          ],
                                        ),
                                      ],
                                      if (event.description != null) ...[
                                        const Divider(
                                          height: 40,
                                        ),
                                        const Text(
                                          'Об этом событие',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(event.description ?? ''),
                                        const Divider(
                                          height: 40,
                                        ),
                                      ],
                                      if (event.place != null) ...[
                                        const Text(
                                          'Локация',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: _place(context, event.place!),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            child: Stack(
                                              children: [
                                                Image.asset(
                                                  Assets.imagesMap,
                                                ),
                                                Positioned.fill(
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.black
                                                              .withAlpha(200),
                                                        ],
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                event.place
                                                                        ?.name ??
                                                                    '',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.next_plan,
                                                              color:
                                                                  Colors.white,
                                                              size: 50,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          height: 40,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          EventExceptionState() => [
                              const Text('Exception'),
                            ]
                        },
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      size: ButtonSize.xl,
                      onPressed: _takeTicket(context),
                      child: const Text('Принять участие'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
