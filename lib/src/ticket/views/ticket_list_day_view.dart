import 'package:dvizh_mob/src/auth/bloc/auth/auth_bloc.dart';
import 'package:dvizh_mob/src/ticket/views/ticket_day_view.dart';
import 'package:dvizh_mob/src/ticket/widgets/ticket_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketListDayView extends StatefulWidget {
  @override
  State<TicketListDayView> createState() => _TicketListDayViewState();
}

class _TicketListDayViewState extends State<TicketListDayView> {
  void _takeDate() {
    final authState = context.read<AuthBloc>().state;
    if(authState is! AuthIsSign) {
      context.push('/auth');
    } else {
      navigateWith2GIS(
        startLat: 55.751244, startLng: 37.618423,
        endLat: 55.7601, endLng: 37.6182,
      );

    }

  }

  Future<void> navigateWith2GIS({
    double startLat = 55.751244, // Координаты Москвы (Красная площадь)
    double startLng = 37.618423,
    double endLat = 55.7601, // Пример: Пушкинская площадь
    double endLng = 37.6182,
    String transportType = "car",
  }) async {
    final deeplink = 'dgis://routeSearch?origin=$startLat,$startLng&destination=$endLat,$endLng&type=$transportType';
    final webUrl = 'https://2gis.ru/routeSearch/rsType/$transportType/from/$startLat,$startLng/to/$endLat,$endLng';

    if (await canLaunchUrl(Uri.parse(deeplink))) {
      await launchUrl(Uri.parse(deeplink));
    } else {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }




  @override
  Widget build(BuildContext context) => SliverList.separated(
    itemBuilder: (context, index) => TicketTileWidget(
      onPressed: _takeDate,
    ),
    separatorBuilder: (context, index) => const Divider(),
    itemCount: 10,
  );
}
