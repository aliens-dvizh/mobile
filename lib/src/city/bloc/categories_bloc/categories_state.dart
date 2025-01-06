part of 'categories_bloc.dart';

sealed class CitiesState {}

final class CitiesInitialState extends CitiesState {}

final class CitiesLoadingState extends CitiesState {}

final class CitiesLoadedState extends CitiesState {
  CitiesLoadedState({required this.categories});

  final ListDataModel<CityModel> categories;
}

final class CitiesExceptionState extends CitiesState {}
