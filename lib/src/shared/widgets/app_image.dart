// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.image,
    this.height,
    this.width,
  });

  final String? image;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.network(
            image ?? '',
            fit: BoxFit.cover,
            cacheWidth: 1000,
            loadingBuilder: (context, image, progress) {
              if (progress != null) {
                return const SizedBox(
                  width: double.infinity,
                  child: Offstage(),
                );
              }
              return image;
            },
            errorBuilder: (context, error, stackTrace) => Container(
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.black,
              child: const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      );
}

class AppImageAsset extends StatelessWidget {
  const AppImageAsset({
    super.key,
    this.image,
    this.height,
    this.width,
  });

  final String? image;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
    ),
    width: width,
    height: height,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        image ?? '',
        fit: BoxFit.cover,
        cacheWidth: 1000,
        errorBuilder: (context, error, stackTrace) => Container(
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.black,
          child: const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            ),
          ),
        ),
      ),
    ),
  );
}