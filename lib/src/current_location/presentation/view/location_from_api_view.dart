import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/city_from_ip_bloc/city_from_ip_bloc.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/current_location/current_location_bloc.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/current_location_view/current_location_view_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

class LocationFromApiView extends StatefulWidget {

  @override
  State<LocationFromApiView> createState() => _LocationFromApiViewState();
}

class _LocationFromApiViewState extends State<LocationFromApiView> {
  void _no() {
    context.read<CurrentLocationViewCubit>().set(CurrentLocationViewGetFromList());
  }

  VoidCallback _yes(CityModel city) => () {
    context
        .read<CurrentLocationBloc>()
        .add(SetCurrentLocationEvent(city: city));
    context.pop();
  };

  @override
  void initState() {
    super.initState();
    context.read<CityFromIPBloc>().add(CityFromIPFetchEvent());
  }

  void _listener(BuildContext context, CityFromIPState state) {
    if(state is CityFromIPExceptionState) context.read<CurrentLocationViewCubit>().set(CurrentLocationViewGetFromList());
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<CityFromIPBloc, CityFromIPState>(
        listener: _listener,
        builder: (context, state) => switch(state) {
            CityFromIPInitialState() ||
            CityFromIPLoadingState() => CupertinoActivityIndicator(),
            CityFromIPLoadedState state => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: state.city.name, style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 21,
                      ),),
                      TextSpan(text: ' '),
                      TextSpan(text: 'это ваш город?'),
                    ],
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        child: Text('Нет'),
                        onPressed: _no,
                      ),
                    ),
                    Expanded(
                      child: ButtonWidget(
                        color: ButtonColor.black,
                        onPressed: _yes(state.city),
                        child: Text('Да'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CityFromIPExceptionState() => throw UnimplementedError(),
          },
      );
}