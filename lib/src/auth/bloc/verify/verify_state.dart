part of 'verify_bloc.dart';

sealed class VerifyState {}

class VerifyInitial extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifySuccess extends VerifyState {}

class VerifyError extends VerifyState {}

class VerifyNetworkError extends VerifyState {}
