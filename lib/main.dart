import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/auth/data/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'app.dart';
import 'core/services/dio/dio_service.dart';
import 'core/services/talker/talker_service.dart';
import 'src/events/export.dart';

void main() async {
  final DependenciesInit dependenciesInit = DependenciesInit();
  final dependencies = await dependenciesInit.init(
    progress: [
      (progress) async => TalkerService(
            Talker(),
          ),
      (progress) async => DioService.initialize(
            'http://localhost',
          )..addInterceptor(
              TalkerDioLogger(
                talker: progress.dependencies.get<TalkerService>().talker,
                settings: const TalkerDioLoggerSettings(),
              ),
            ),
      (progress) async => EventRepository(
            EventDataSource(
              progress.dependencies.get<DioService>(),
            ),
          ),
      (progress) async => AuthRepository(
            TokenDataSource(
              FlutterSecureStorage(),
            ),
            AuthDataSource(
              progress.dependencies.get<DioService>(),
            ),
            AuthInterceptorDataSource(
              progress.dependencies.get<DioService>(),
            ),
          ),
    ],
  );
  FlutterError.onError = (FlutterErrorDetails details) {
    dependencies.get<TalkerService>().talker.error(
          details.exceptionAsString(),
          details.stack.toString(),
        );
  };

  Bloc.observer = TalkerBlocObserver(
    talker: dependencies.get<TalkerService>().talker,
  );

  App(
    dependencies: dependencies,
  ).attach();
}
