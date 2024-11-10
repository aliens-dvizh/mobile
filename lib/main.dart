// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/app.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';
import 'package:dvizh_mob/src/events/export.dart';

void main() async {
  final rootLibrary = RootLibrary();

  FlutterError.onError = (details) {
    rootLibrary.talker.error(
      details.exceptionAsString(),
      details.stack.toString(),
    );
  };

  Bloc.observer = TalkerBlocObserver(
    talker: rootLibrary.talker,
  );

  runZonedGuarded(
    () => runApp(
      Dependencies(
        library: rootLibrary,
        placeholder: const Center(
          child: CircularProgressIndicator(),
        ),
        child: const App(),
      ),
    ),
    (error, stackTrace) {
      rootLibrary.talker.error(
        error.toString(),
        stackTrace.toString(),
      );
    },
  );
}

class RootLibrary extends DependenciesLibrary<void> {
  final Talker talker = Talker();
  late final DioService dioService;
  late final EventRepository eventRepository;

  @override
  Future<void> init() async {
    dioService = DioService.initialize(
      'http://localhost',
    )..addInterceptor(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(),
        ),
      );
    eventRepository = EventRepository(
      EventDataSource(
        dioService,
      ),
    );
  }
}
