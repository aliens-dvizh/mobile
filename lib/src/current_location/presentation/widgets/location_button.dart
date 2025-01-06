import 'package:dvizh_mob/src/current_location/domain/blocs/current_location/current_location_bloc.dart';
import 'package:dvizh_mob/src/current_location/presentation/view/current_location_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationButton extends StatefulWidget {
  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  void _onPressed() {
    CurrentLocationView().view(context);
  }

  void _listener(BuildContext context, CurrentLocationState state) {
    if(state is CurrentLocationInitial) {
      CurrentLocationView().view(context);
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<CurrentLocationBloc, CurrentLocationState>(
        listener: _listener,
        builder: (context, state) => switch(state) {
            CurrentLocationInitial() => TextButton(
              onPressed: _onPressed,
              child: const FittedBox(
                child: Text(
                  'Выбрать город',
                ),
              ),
            ),
            CurrentLocationLoading() => CupertinoActivityIndicator(),
            CurrentLocationExist state => TextButton(
              onPressed: _onPressed,
              child: Text(
                state.city.name,
                style: TextStyle(fontSize: 18),
              ),
            ),
          },
      );
}
