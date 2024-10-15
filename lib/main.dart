
import 'package:depend/depend.dart';
import 'package:dvizh_mob/core/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'app.dart';
import 'src/events/export.dart';

void main() async {
  final Talker talker = Talker();
  final dependencies = await DependenciesInit().init(
    progress: [
      (progress) async => DioService.initialize(
            'http://localhost',
          )..addInterceptor(
              TalkerDioLogger(
                talker: talker,
                settings: const TalkerDioLoggerSettings(
                  printRequestHeaders: true,
                  printResponseHeaders: true,
                  printResponseMessage: true,
                ),
              ),
            ),
      (progress) async => EventRepository(
            EventDataSource(
              progress.dependencies.get<DioService>(),
            ),
          ),
    ],
  );
  FlutterError.onError = (FlutterErrorDetails details) {
    talker.error(
      details.exceptionAsString(),
      details.stack.toString(),
    );
  };

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
  );

  App(
    dependencies: dependencies,
  ).attach();
}
