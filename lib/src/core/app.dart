// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:depend/depend.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/dependency/root_dependency_factory.dart';
import 'package:dvizh_mob/src/core/material_app.dart';

class App {
  Future<void> run() async {
    final rootLibrary = await RootDependencyFactory().create();

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
          child: MyApp(),
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
}
