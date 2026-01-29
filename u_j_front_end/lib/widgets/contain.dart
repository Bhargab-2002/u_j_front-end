import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const AppContainer({
    super.key,
    required this.child,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: width ?? (screenWidth > 900 ? 900 : screenWidth * 0.95),
        padding: padding ?? const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
