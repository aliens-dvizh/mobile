import 'package:dvizh_mob/src/city/bloc/categories_bloc/categories_bloc.dart';
import 'package:dvizh_mob/src/city/models/category_model.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/current_location/current_location_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

class LocationFromListView extends StatefulWidget {
  @override
  State<LocationFromListView> createState() => _LocationFromListViewState();
}

class _LocationFromListViewState extends State<LocationFromListView> {
  late ValueNotifier<CityModel?> _notifier;

  void Function(bool? value) _onPressed(CityModel city) => (value) {
        _notifier.value = city;
      };

  void _submit() {
    if (_notifier.value == null) return;
    context.pop();
    context
        .read<CurrentLocationBloc>()
        .add(SetCurrentLocationEvent(city: _notifier.value!));
  }

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier(_getCurrentCity());
  }

  CityModel? _getCurrentCity() =>
      switch (context.read<CurrentLocationBloc>().state) {
        CurrentLocationInitial() ||
        CurrentLocationLoading() =>
          null,
        CurrentLocationExist state => state.city,
      };

  void _listener(BuildContext context, CurrentLocationState state) {
    if (state is CurrentLocationExist) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _notifier,
        builder: (context, value, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: BlocBuilder<CitiesBloc, CitiesState>(
                builder: (context, state) => switch (state) {
                  CitiesInitialState() ||
                  CitiesLoadingState() =>
                    const CupertinoActivityIndicator(),
                  CitiesLoadedState() => ListView.separated(
                      itemCount: state.categories.list.length,
                      itemBuilder: (context, item) {
                        final city = state.categories.list[item];
                        return CheckboxListTile(
                          title: Text(
                            city.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          value: city.id == value?.id,
                          onChanged: _onPressed(city),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                    ),
                  CitiesExceptionState() => Text('Exception')
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: BlocConsumer<CurrentLocationBloc, CurrentLocationState>(
                listener: _listener,
                builder: (context, state) => ButtonWidget(
                  size: ButtonSize.xl,
                  isLoading: state is CurrentLocationLoading,
                  onPressed: value != null ? _submit : null,
                  child: Text('Выбрать'),
                ),
              ),
            )
          ],
        ),
      );
}
