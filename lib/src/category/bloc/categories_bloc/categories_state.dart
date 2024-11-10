part of 'categories_bloc.dart';

sealed class CategoriesState {}

final class CategoriesInitialState extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesLoadedState extends CategoriesState {
  CategoriesLoadedState({required this.categories});

  final ListDataModel<CategoryModel> categories;
}

final class CategoriesExceptionState extends CategoriesState {}
