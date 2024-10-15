import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:dvizh_mob/core/services/talker/talker_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _toTalker() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TalkerScreen(
          talker: Dependencies.of(context).get<TalkerService>().talker,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutoRouter(),
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              onPressed: _toTalker,
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
