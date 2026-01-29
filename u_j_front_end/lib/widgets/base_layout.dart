import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'stepper_bar.dart';

class BaseLayout extends StatelessWidget {
  final int step;
  final String title;
  final Widget child;

  const BaseLayout({
    super.key,
    required this.step,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          // 🔷 TOP DARK BAR
          Container(
            height: 70,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            color: AppColors.secondary,
            alignment: Alignment.centerLeft,
            child: const Icon(
              Icons.family_restroom,
              color: Colors.white,
            ),
          ),

          // 🔷 CONTENT
          Expanded(
            child: Center(
              child: Container(
                width: width > 900 ? 900 : width * 0.95,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StepperBar(currentStep: step),
                    const SizedBox(height: 30),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
