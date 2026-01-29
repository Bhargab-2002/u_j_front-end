// lib/screen/review/widgets/section_header.dart
import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

