import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CrochetImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  const CrochetImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(16);

    return ClipRRect(
      borderRadius: radius,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.peach.withValues(alpha: 0.5),
                  AppColors.blush.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: radius,
            ),
            child: const Center(
              child: Icon(
                Icons.auto_awesome,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          );
        },
      ),
    );
  }
}
