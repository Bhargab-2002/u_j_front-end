import 'package:flutter/material.dart';

class ApplicationHeader extends StatelessWidget {
  final double height;

  const ApplicationHeader({
    super.key,
    this.height = 80, // ✅ same height everywhere
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF143A6E), // ✅ single authoritative color
      ),
      alignment: Alignment.centerLeft,
      child: Container(
        height: 42,
        width: 42,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1),
        ),
        child: Image.asset(
          '/Users/bhargabdas/FlutterDev/res/images/IMG_6821.jpg', // ✅ RELATIVE PATH ONLY
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
