// 🌎 Project imports:
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_factory.dart';
import 'package:dvizh_mob/src/core/material_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

void main() {
  final container = RootDependencyFactory().create();

  FlutterError.onError = (details) {
    container.talker.error(
      details.exceptionAsString(),
      details.stack.toString(),
    );
  };

  Bloc.observer = TalkerBlocObserver(
    talker: container.talker,
  );

  runZonedGuarded(
    () => runApp(
      MyApp(container: container,),
    ),
    (error, stackTrace) {
      container.talker.error(
        error.toString(),
        stackTrace.toString(),
      );
    },
  );
}
