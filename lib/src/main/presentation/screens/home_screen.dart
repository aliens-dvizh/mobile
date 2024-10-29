// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:talker_flutter/talker_flutter.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/core/router/auto_route.gr.dart';
import 'package:dvizh_mob/main.dart';

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
          talker: Dependencies.of<RootLibrary>(context).talker,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        EventsRoute(),
        ProfileRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          appBar: AppBar(
            title: Text(
              'DVIZH',
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.event),
              ),
              BottomNavigationBarItem(
                label: 'User',
                icon: Icon(Icons.person),
              ),
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
