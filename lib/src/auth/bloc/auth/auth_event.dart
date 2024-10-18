part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLogin extends AuthEvent {}

class AuthLogout extends AuthEvent {}

class Unauthenticated extends AuthEvent {}

class DeleteAccountReal extends AuthEvent {}
