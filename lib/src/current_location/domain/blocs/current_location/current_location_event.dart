part of 'current_location_bloc.dart';

sealed class CurrentLocationEvent {}

final class SetCurrentLocationEvent extends CurrentLocationEvent {
  SetCurrentLocationEvent({required this.city});

  final CityModel city;
}

final class GetCurrentLocationEvent extends CurrentLocationEvent {}