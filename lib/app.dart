import 'dart:async';

import 'package:depend/depend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'material_app.dart';
import 'src/events/export.dart';

class App extends StatefulWidget {
  final DependenciesLibrary dependencies;
  const App({super.key, required this.dependencies});

  void attach() => runApp(this);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Dependencies(
      dependencies: widget.dependencies,
      child: MyApp(),
    );
  }
}
