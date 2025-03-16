// 🐦 Flutter imports:
import 'package:dvizh_mob/src/auth/bloc/auth/auth_bloc.dart';
import 'package:dvizh_mob/src/core/router/wrapped_route.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/current_location/current_location_bloc.dart';
import 'package:dvizh_mob/src/current_location/domain/blocs/current_location_view/current_location_view_cubit.dart';
import 'package:dvizh_mob/src/current_location/presentation/widgets/location_button.dart';
import 'package:dvizh_mob/src/user/bloc/user/user_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:toptom_widgetbook/kit/export.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/shared/widgets/media_query_scope.dart';

class HomeScreen extends StatefulWidget implements WrappedRoute {
  const HomeScreen({
    required this.child,
    required this.state,
    super.key,
  });

  final Widget child;
  final GoRouterState state;

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider<CurrentLocationViewCubit>(
        create: (context) => CurrentLocationViewCubit(),
        child: this,
      );
}

class _HomeScreenState extends State<HomeScreen> {
  final routes = [
    MainNavigationItem(label: 'События', icon: Icons.event, path: '/'),
    MainNavigationItem(label: 'Профиль', icon: Icons.person, path: '/profile'),
  ];

  void _toTalker() {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => TalkerScreen(
          talker:
              DependencyProvider.of<RootDependencyContainer>(context).talker,
        ),
      ),
    );
  }

  void _setActiveScreen(int value) {
    context.go(routes[value].path);
  }

  @override
  void initState() {
    super.initState();
    context.read<CurrentLocationBloc>().add(GetCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) => MediaQueryScope(
        builder: (context, type) => Scaffold(
          body: widget.child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: routes
                .indexWhere((route) => route.path == widget.state.fullPath),
            onTap: _setActiveScreen,
            items: routes
                .map(
                  (route) => BottomNavigationBarItem(
                    label: route.label,
                    icon: Icon(route.icon),
                  ),
                )
                .toList(),
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
}

class MainNavigationItem {
  MainNavigationItem({
    required this.label,
    required this.icon,
    required this.path,
  });

  final String label;
  final IconData icon;
  final String path;
}
