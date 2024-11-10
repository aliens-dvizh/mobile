part of 'user_bloc.dart';

sealed class UserState {}

final class UserInitialState extends UserState {}

final class UserLoadedState extends UserState {
  UserLoadedState({required this.user});

  final UserModel user;
}

final class UserLoadingState extends UserState {}

final class UserExceptionState extends UserState {}
