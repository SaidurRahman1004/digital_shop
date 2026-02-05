import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppLogo({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final double defaultSize = MediaQuery.of(context).size.width * 0.25;

    return Image.asset(
      'assets/images/appLogo.png',
      width: width ?? defaultSize, // 25 percent of screen width
      height: height,
      fit: fit,
      // animation
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image, size: 50),
    );
  }
}
