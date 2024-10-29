// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/auth/data/export.dart';
import 'app.dart';
import 'core/services/dio/dio_service.dart';
import 'src/events/export.dart';

void main() async {
  final rootLibrary = RootLibrary();

  FlutterError.onError = (FlutterErrorDetails details) {
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
        child: App(),
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

class RootLibrary extends DependenciesLibrary {
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
