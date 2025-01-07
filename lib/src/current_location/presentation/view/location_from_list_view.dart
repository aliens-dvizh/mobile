import 'dart:async';

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
  late TextEditingController _searchController;
  late ValueNotifier<CityModel?> _notifier;
  late StreamSubscription<CurrentLocationState> _subscription;

  void Function(bool? value) _onPressed(CityModel city) => (bool? value) {
    if(value == null) return;
    if(!value) return;

    _notifier.value = city;
    context
        .read<CurrentLocationBloc>()
        .add(SetCurrentLocationEvent(city: city));
      };

  void _submit() {
    context
        .read<CurrentLocationBloc>()
        .add(SetCurrentLocationEvent(city: _notifier.value!));
  }

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier(_getCurrentCity());
    _searchController = TextEditingController();
    _subscription = context.read<CurrentLocationBloc>().stream.listen(_listener);
  }

  CityModel? _getCurrentCity() =>
      switch (context.read<CurrentLocationBloc>().state) {
        CurrentLocationInitial() || CurrentLocationLoading() => null,
        CurrentLocationExist state => state.city,
      };

  void _listener( CurrentLocationState state) {
    if (state is CurrentLocationExist) {
      context.pop();
    }
  }

  @override
  void dispose() {
    _notifier.dispose();
    _searchController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _notifier,
        builder: (context, value, child) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ваш город", style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 24
            ),),
            SizedBox(height: 16,),
            TextFieldWidget(
              hintText: 'Найти город',
              controller: _searchController,
            ),

            Expanded(
              child: BlocBuilder<CitiesBloc, CitiesState>(
                builder: (context, state) => switch (state) {
                  CitiesInitialState() ||
                  CitiesLoadingState() =>
                    const CupertinoActivityIndicator(),
                  CitiesLoadedState() => ValueListenableBuilder(
                      valueListenable: _searchController,
                      builder: (context, search, child) {
                        final sortedList = [
                          ...state.categories.list
                            ..sort((a, b) => a.name.compareTo(b.name))
                        ].where((city) => city.name.toLowerCase().contains(search.text.toLowerCase())).toList();

                        return ListView.separated(
                          itemCount: sortedList.length,
                          itemBuilder: (context, item) {
                            final city = sortedList[item];
                            final previousCity =
                                item > 0 ? sortedList[item - 1] : null;

                            final showSeparator = previousCity == null ||
                                city.name[0] != previousCity.name[0];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: showSeparator,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      city.name[0], // Первая буква
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                CheckboxListTile(
                                  title: Text(
                                    city.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  value: city.id == value?.id,
                                  onChanged: _onPressed(city),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                        );
                      },
                    ),
                  CitiesExceptionState() => Text('Exception')
                },
              ),
            ),
          ],
        ),
      );
}
