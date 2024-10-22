import 'package:depend/depend.dart';
import 'package:flutter/material.dart';
import 'package:toptom_widgetbook/kit/export.dart';

import 'material_app.dart';

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
      child: ThemeSwitcher(
        child: MyApp(),
      ),
    );
  }
}
