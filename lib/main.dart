// 🌎 Project imports:
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_factory.dart';
import 'package:dvizh_mob/src/core/material_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  final talker = Talker();

  await Zone.current.fork(specification: ZoneSpecification(
    errorCallback: (zone, delegate, zone2, object, stackTrace) {
      talker.error(
        object.toString(),
        stackTrace.toString(),
      );
      return null;
    }
  )).run(() async {
    await Supabase.initialize(
      url: 'https://vpxecthvwpyzfbrvvadq.supabase.co',
      anonKey:
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZweGVjdGh2d3B5emZicnZ2YWRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA3ODYzMjcsImV4cCI6MjA1NjM2MjMyN30.mcjXjYFV3n85pQuoHDDKxFK-M0lPz8puva3D4mmlqac',
    );
    final container = RootDependencyFactory(
      talker: talker,
    ).create();

    Bloc.observer = TalkerBlocObserver(
      talker: container.talker,
    );
    runApp(
      MyApp(
        container: container,
      ),
    );
  });
}
