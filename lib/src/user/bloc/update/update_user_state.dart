part of 'update_user_bloc.dart';

sealed class UpdateUserState {}

final class UpdateUserInitialState extends UpdateUserState {}

final class UpdateUserLoadingState extends UpdateUserState {}

final class UpdateUserLoadedState extends UpdateUserState {}

final class UpdateUserExceptionState extends UpdateUserState {}
