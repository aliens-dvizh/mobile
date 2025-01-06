// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, this.image, this.height, this.width});

  final String? image;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) => Image.network(
        image ?? '',
        fit: BoxFit.cover,
        loadingBuilder: (context, image, progress) {
          if (progress != null)
            return const Center(child: CupertinoActivityIndicator());
          return image;
        },
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(
            Icons.error,
            color: Colors.red,
            size: 30,
          ),
        ),
        width: width,
        height: height,
      );
}
