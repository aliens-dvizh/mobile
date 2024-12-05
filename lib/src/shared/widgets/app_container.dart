// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/shared/widgets/media_query_scope.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: switch (MediaQueryScope.ofType(context)) {
          MediaType.sm || MediaType.md => 16,
          MediaType.lg => 200
        }),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            child: child,
          ),
        ),
      );
}
