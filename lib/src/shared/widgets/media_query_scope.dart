// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

class MediaQueryScope<T extends MediaType> extends StatelessWidget {
  const MediaQueryScope({required this.builder, super.key});

  final Widget Function(BuildContext context, MediaType type) builder;

  static MediaType ofType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    for (var i = 0; i < MediaType.values.length; i++) {
      final currentType = MediaType.values[i];
      final nextType = MediaType.values[i + 1];
      if (currentType.breakpoint < width && nextType.breakpoint >= width) {
        return nextType;
      } else if (currentType.breakpoint > width) {
        return currentType;
      }
    }

    return MediaType.values.last;
  }

  @override
  Widget build(BuildContext context) => builder(context, ofType(context));
}

enum MediaType {
  sm(breakpoint: 600),
  md(breakpoint: 1200),
  lg(breakpoint: 1900);

  const MediaType({required this.breakpoint});

  final double breakpoint;
}
