part of 'current_location_bloc.dart';

sealed class CurrentLocationState {}

final class CurrentLocationInitial extends CurrentLocationState {}

final class CurrentLocationLoading extends CurrentLocationState {}

final class CurrentLocationExist extends CurrentLocationState {
  CurrentLocationExist({required this.city});

  final CityModel city;
}

