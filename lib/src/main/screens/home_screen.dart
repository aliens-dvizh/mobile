import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:dvizh_mob/core/router/auto_route.gr.dart';
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
  void _toTalker() {
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
    return AutoTabsRouter(
      routes: const [
        EventsRoute(),
      ],
      transitionBuilder: (context,child,animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.event)),
              BottomNavigationBarItem(label: 'User', icon: Icon(Icons.person)),
            ],
          ),
          floatingActionButton: Visibility(
            visible: kDebugMode,
            child: FloatingActionButton(
              onPressed: _toTalker,
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}

