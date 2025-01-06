part of 'city_from_ip_bloc.dart';

sealed class CityFromIPState {}

final class CityFromIPInitialState extends CityFromIPState {}

final class CityFromIPLoadingState extends CityFromIPState {}

final class CityFromIPLoadedState extends CityFromIPState {
  CityFromIPLoadedState({required this.city});

  final CityModel city;
}

final class CityFromIPExceptionState extends CityFromIPState {}
