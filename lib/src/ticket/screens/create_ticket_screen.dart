import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/events/bloc/event/event_bloc.dart';
import 'package:dvizh_mob/src/events/dto/event_dto.dart';
import 'package:dvizh_mob/src/shared/widgets/app_image.dart';
import 'package:dvizh_mob/src/ticket/controllers/create_ticket/create_ticket_cubit.dart';
import 'package:dvizh_mob/src/ticket/views/have_ticket_alert_view.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateTicketScreenParams {
  CreateTicketScreenParams({required this.id});

  factory CreateTicketScreenParams.fromMap(Map<String, String> parameters) =>
      CreateTicketScreenParams(
        id: int.parse(parameters['id'] as String),
      );

  final int id;
}

class CreateTicketScreen extends StatefulWidget implements WrappedRoute {
  const CreateTicketScreen({
    required this.params,
    super.key,
  });

  final CreateTicketScreenParams params;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => CreateTicketCubit(
          context.depend<RootDependencyContainer>().tickerRepository,
        ),
        child: this,
      );

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  VoidCallback _create(BuildContext context) => () {
        context.read<CreateTicketCubit>().create(eventId: widget.params.id);
      };

  VoidCallback _changeProfile(BuildContext context) => () {
        context.push('/profile/update');
      };

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
  void initState() {
    super.initState();
    context.read<EventBloc>().add(EventFetchEvent(widget.params.id));
  }

  void _listener(BuildContext context, CreateTicketState state) {
    if (state case CreateTicketLoadedState state) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      context.push('/ticket/${state.ticket.id}');
    } else if (state case CreateHaveTicketExceptionState state) {
      HaveTicketAlertView(ticketId: state.ticketId).view(context);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text('Checkout'),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList.list(
                      children: [
                        Builder(
                          builder: (context) {
                            final eventState = context.watch<EventBloc>().state;
                            return switch (eventState) {
                              EventInitialState() ||
                              EventLoadingState() =>
                                const Text('Loading...'),
                              EventLoadedState state => Row(
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppImage(
                                      image:
                                          state.event.images.firstOrNull?.url,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.25,
                                      height: MediaQuery.sizeOf(context).width *
                                          0.25,
                                    ),
                                    Expanded(
                                      child: Column(
                                        spacing: 10,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (state.event.category != null)
                                            Text(
                                              state.event.category?.name ?? '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    Colors.black.withAlpha(230),
                                              ),
                                            ),
                                          Text(
                                            state.event.name,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              EventExceptionState() => Text('Exception...'),
                            };
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.date_range,
                                size: 30,
                              ),
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final eventState =
                                        context.watch<EventBloc>().state;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Дата:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        switch (eventState) {
                                          EventInitialState() ||
                                          EventLoadingState() =>
                                            Text('Loading...'),
                                          EventLoadedState() => Text(
                                              DateFormat('dd MMMM hh:mm')
                                                  .format(eventState
                                                      .event.holdedAt!),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          EventExceptionState() ||
                                          EventLoadingState() =>
                                            Text('Exception...'),
                                        }
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        IntrinsicHeight(
                          child: Builder(builder: (context) {
                            final eventState = context.watch<EventBloc>().state;
                            return switch (eventState) {
                              EventInitialState() ||
                              EventLoadingState() =>
                                Text('Loading...'),
                              EventLoadedState state
                                  when (state.event.place != null) =>
                                Row(
                                  spacing: 8,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.place_outlined,
                                      size: 30,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Место:',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(
                                            eventState.event.place?.name ?? '',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        onPressed: _place(
                                            context, eventState.event.place!),
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              EventExceptionState() => Text('exception'),
                              EventLoadedState() => Offstage(),
                            };
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Builder(
                          builder: (context) {
                            final userState = context.watch<UserBloc>().state;
                            return switch (userState) {
                              UserInitialState() => Offstage(),
                              UserLoadedState state => Column(
                                  spacing: 20,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        spacing: 8,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.person_outline,
                                            size: 30,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Контактная информация',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Text(
                                                  state.user.name,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '+${state.user.phone}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: IconButton(
                                              onPressed:
                                                  _changeProfile(context),
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              UserLoadingState() =>
                                CupertinoActivityIndicator(),
                              UserExceptionState() => Offstage(),
                            };
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.cancel_outlined,
                                size: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Политика отмены билета',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      '''Мы понимаем, что планы могут меняться, поэтому предлагаем гибкую систему отмены: Отмена без последствий – за 12 часов до события. Поздняя отмена – за 1 час до события, снижает приоритет в будущих бронированиях. Неявка без отмены – может повлиять на рейтинг и ограничить доступ к популярным событиям. Чтобы избежать проблем, рекомендуем своевременно отменять бронирование через приложение.''',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withAlpha(240),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(),
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
                  padding: const EdgeInsets.all(16),
                  child: BlocConsumer<CreateTicketCubit, CreateTicketState>(
                    listener: _listener,
                    builder: (context, state) {
                      return switch (state) {
                        CreateTicketExceptionState() ||
                        CreateTicketLoadedState() ||
                        CreateTicketInitialState() ||
                        CreateHaveTicketExceptionState() =>
                          ElevatedButton(
                            onPressed: _create(context),
                            child: Text('Create'),
                          ),
                        CreateTicketLoadingState() => ElevatedButton(
                            onPressed: () {},
                            child: CupertinoActivityIndicator(),
                          ),
                      };
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
