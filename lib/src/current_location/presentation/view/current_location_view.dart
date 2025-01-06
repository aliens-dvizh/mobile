import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/city_from_ip_bloc/city_from_ip_bloc.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/current_location_view/current_location_view_cubit.dart';
import 'package:dvizh_mob/src/current_location/presentation/view/location_from_api_view.dart';
import 'package:dvizh_mob/src/current_location/presentation/view/location_from_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentLocationView extends StatelessWidget implements WrappedRoute {
  Future<Object?> view(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (innerContext) => wrappedRoute(context),
        isScrollControlled: true,
        useSafeArea: true,
      );

  @override
  Widget wrappedRoute(BuildContext context) {
    final container = context.depend<RootDependencyContainer>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CityFromIPBloc>(
          lazy: true,
          create: (context) => CityFromIPBloc(
            container.currentLocationRepository,
          ),
        ),
        BlocProvider.value(
          value: context.read<CurrentLocationViewCubit>(),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CurrentLocationViewCubit, CurrentLocationViewState>(
          builder: (context, state) => switch (state) {
            CurrentLocationViewInitial() ||
            CurrentLocationViewGetFromIP() =>
              LocationFromApiView(),
            CurrentLocationViewGetFromList() => LocationFromListView(),
          },
        ),
      );
}
