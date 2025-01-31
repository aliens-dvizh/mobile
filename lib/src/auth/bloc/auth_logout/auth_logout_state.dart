part of 'auth_logout_bloc.dart';

sealed class AuthLogoutState {}

class AuthLogoutInitial extends AuthLogoutState {}

class AuthLogoutLoading extends AuthLogoutState {}

class AuthLogoutError extends AuthLogoutState {
  AuthLogoutError({required this.error});
  final String error;
}

class AuthLogoutSuccess extends AuthLogoutState {}