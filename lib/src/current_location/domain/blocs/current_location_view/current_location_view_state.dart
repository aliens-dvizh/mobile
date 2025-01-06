part of 'current_location_view_cubit.dart';

sealed class CurrentLocationViewState {}

final class CurrentLocationViewInitial extends CurrentLocationViewState {}

final class CurrentLocationViewGetFromIP extends CurrentLocationViewState {}

final class CurrentLocationViewGetFromList extends CurrentLocationViewState {}


