import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class StepperBar extends StatelessWidget {
  final int currentStep;

  const StepperBar({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final labels = [
      'Insurance type',
      'Personal Info',
      'Policy Info',
      'Review',
      'Payment',
    ];

    return Row(
      children: List.generate(labels.length, (index) {
        final step = index + 1;
        final isActive = step == currentStep;
        final isCompleted = step < currentStep;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  // LEFT LINE
                  Expanded(
                    child: index == 0
                        ? const SizedBox(height: 3)
                        : Container(
                      height: 3,
                      color: step <= currentStep
                          ? AppColors.stepActive
                          : AppColors.stepLine,
                    ),
                  ),

                  // CIRCLE
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: isActive || isCompleted
                        ? AppColors.stepActive
                        : AppColors.stepInactive,
                    child: Text(
                      '$step',
                      style: TextStyle(
                        color: isActive || isCompleted
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // RIGHT LINE
                  Expanded(
                    child: index == labels.length - 1
                        ? const SizedBox(height: 3)
                        : Container(
                      height: 3,
                      color: step < currentStep
                          ? AppColors.stepActive
                          : AppColors.stepLine,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // LABEL
              SizedBox(
                width: 90,
                child: Text(
                  labels[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    color: isActive
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}