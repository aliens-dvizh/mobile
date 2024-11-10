part of 'user_bloc.dart';

sealed class UserEvent {}

final class UserFetchEvent extends UserEvent {}

final class _UserClearEvent extends UserEvent {}

final class _UserChangeEvent extends UserEvent {
  _UserChangeEvent(this.user);

  final UserModel user;
}
