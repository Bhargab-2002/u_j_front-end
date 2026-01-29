import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class InsuranceCard extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onSelect;

  const InsuranceCard({
    super.key,
    required this.title,
    required this.color,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(
            color: color,
            width: 6,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔷 TITLE
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 12),

          // 🔷 DESCRIPTION
          const Text(
            'Comprehensive health coverage with flexible benefits',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 20),

          // 🔷 POINTS
          _point('Coverage for Self, Spouse & Kids'),
          _point('Zone-based pricing'),
          _point('Room rent & maternity options'),

          const Spacer(),

          // 🔷 SELECT BUTTON (FIXED)
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 42,
              child: ElevatedButton(
                onPressed: onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white, // ✅ FIXED
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔧 Bullet point row
  Widget _point(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
