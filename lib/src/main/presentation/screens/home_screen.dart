// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:toptom_widgetbook/kit/export.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/core/router/auto_route.gr.dart';
import 'package:dvizh_mob/src/shared/widgets/media_query_scope.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _toTalker() {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => TalkerScreen(
          talker: DependencyProvider.of<RootLibrary>(context).talker,
        ),
      ),
    );
  }

  VoidCallback _toPage(TabsRouter router, int index) =>
      () => router.setActiveIndex(index);

  @override
  Widget build(BuildContext context) => AutoTabsRouter(
        routes: const [
          EventWrappedRoute(),
          UserWrappedRoute(),
        ],
        transitionBuilder: (context, child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return MediaQueryScope(
            builder: (context, type) => Scaffold(
              body: Column(
                children: [
                  switch (type) {
                    MediaType.sm || MediaType.md => AppBar(
                        title: const Text(
                          'DVIZH',
                        ),
                        titleTextStyle:
                            ThemeCore.of(context).typography.h3.copyWith(
                                  color: Colors.black,
                                ),
                        titleSpacing: 0,
                      ),
                    MediaType.lg => AppBar(
                        title: const Text(
                          'DVIZH',
                        ),
                        titleTextStyle:
                            ThemeCore.of(context).typography.h3.copyWith(
                                  color: Colors.black,
                                ),
                        actions: [
                          ButtonWidget(
                            onPressed: _toPage(tabsRouter, 0),
                            child: const Text('Profile'),
                          ),
                          ButtonWidget(
                            onPressed: _toPage(tabsRouter, 1),
                            child: const Text('User'),
                          )
                        ],
                      ),
                  },
                  Expanded(child: child),
                  if ([MediaType.sm, MediaType.md].contains(type))
                    BottomNavigationBar(
                      currentIndex: tabsRouter.activeIndex,
                      onTap: tabsRouter.setActiveIndex,
                      items: const [
                        BottomNavigationBarItem(
                          label: 'Profile',
                          icon: Icon(Icons.event),
                        ),
                        BottomNavigationBarItem(
                          label: 'User',
                          icon: Icon(Icons.person),
                        ),
                      ],
                    )
                  else
                    const Offstage(),
                ],
              ),
              floatingActionButton: Visibility(
                visible: kDebugMode,
                child: FloatingActionButton(
                  onPressed: _toTalker,
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          );
        },
      );
}
