import 'dart:ui' as ui;

import 'package:depend/depend.dart';
import 'package:dvizh_mob/generated/assets.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/events/dto/event_dto.dart';
import 'package:dvizh_mob/src/ticket/controllers/ticket/ticket_cubit.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';
import 'package:dvizh_mob/src/ticket/views/cancel_ticket_alert_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketScreenParams {
  TicketScreenParams({required this.id});

  factory TicketScreenParams.fromMap(Map<String, String> parameters) =>
      TicketScreenParams(
        id: int.parse(parameters['id'] as String),
      );

  final int id;
}

class TicketScreen extends StatefulWidget implements WrappedRoute {
  const TicketScreen({required this.params, super.key});

  final TicketScreenParams params;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => TicketCubit(
          context.depend<RootDependencyContainer>().tickerRepository,
        ),
        child: this,
      );

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<TicketCubit>().fetch(widget.params.id);
  }

  Future<void> _saveQR() async {
    try {
      final boundary = _globalKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage();

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return;
      final pngBytes = byteData.buffer.asUint8List();

      await Share.shareXFiles(
        [
          XFile.fromData(
            pngBytes,
            mimeType: 'image/png',
            name: 'screenshot.png',
          )
        ],
      );
    } catch (e) {
      print('Ошибка: $e');
    }
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

  void _cancelTicket() {
    CancelTicketAlertView(ticketId: widget.params.id,).view(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Билет'),
              floating: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              actions: [
                IconButton(
                  onPressed: _saveQR,
                  icon: Icon(
                    Icons.share,
                  ),
                ),
              ],
            ),
            BlocBuilder<TicketCubit, TicketState>(
              builder: (context, state) => switch (state) {
                TicketInitialState() ||
                TicketLoadingState() =>
                  SliverToBoxAdapter(
                    child: CupertinoActivityIndicator(),
                  ),
                TicketLoadedState state => SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverList.list(
                      children: [
                        if(state.ticket.status == TicketStatus.activated) ...[
                          RepaintBoundary(
                            key: _globalKey,
                            child: Container(
                              color: Colors.white,
                              child: QrImageView(
                                data: state.ticket.qrcode,
                              ),
                            ),
                          ),
                          const Divider(
                            height: 40,
                          ),
                        ],
                        if(state.ticket.status == TicketStatus.canceled) ...[
                          Text('Билет отменён', style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),)
                        ],


                        Text(
                          state.ticket.event?.name ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Дата',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              DateFormat('dd MMMM hh:mm').format(
                                state.ticket.event!.holdedAt!,
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (state.ticket.event?.place != null) ...[
                          const Text(
                            'Локация',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: _place(context, state.ticket.event!.place!),
                            borderRadius: BorderRadius.circular(24),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    Assets.imagesMap,
                                  ),
                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withAlpha(200),
                                          ],
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  state.ticket.event?.place
                                                          ?.name ??
                                                      '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.next_plan,
                                                color: Colors.white,
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

                        ],
                        if(state.ticket.status != TicketStatus.canceled) ...[
                          const Divider(
                            height: 40,
                          ),
                          Text('Отменить билет'),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _cancelTicket,
                              child: Text('Отменить'),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                TicketExceptionState() => SliverToBoxAdapter(
                    child: Text('Exception'),
                  ),
              },
            ),
          ],
        ),
      );
}
