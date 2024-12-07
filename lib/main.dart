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
import 'package:dvizh_mob/src/core/app.dart';
import 'package:dvizh_mob/src/core/app_settings.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';

void main() async {
  final rootLibrary = await RootFactory().create();

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
      DependencyProvider(
        dependency: rootLibrary,
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

class RootLibrary extends DependencyContainer {
  RootLibrary({
    required this.dioService,
    required this.talker,
    required this.settings,
    required this.secureStorage,
  });

  final Talker talker;
  final DioService dioService;
  final AppSettings settings;
  final FlutterSecureStorage secureStorage;
}

class RootFactory extends DependencyFactory<RootLibrary> {
  @override
  Future<RootLibrary> create() async {
    final talker = Talker();
    return RootLibrary(
        dioService: DioService.initialize(
          'http://localhost',
        )..addInterceptor(
            TalkerDioLogger(
              talker: talker,
              settings: const TalkerDioLoggerSettings(),
            ),
          ),
        talker: talker,
        settings: AppSettings(useMocks: true),
        secureStorage: const FlutterSecureStorage());
  }
}
