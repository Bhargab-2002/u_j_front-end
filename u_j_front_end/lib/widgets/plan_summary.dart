
// lib/screen/review/widgets/plan_summary.dart
import 'package:flutter/material.dart';
import '../../../models/plan_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';

class PlanSummary extends StatelessWidget {
  final Plan plan;

  const PlanSummary({super.key, required this.plan});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.successGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Plan Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _buildInfoColumn(
                  'SELECTED PREMIUM',
                  plan.premiumType,
                  showIcon: true,
                ),
              ),
              Expanded(
                child: _buildInfoColumn(
                  'TOTAL PREMIUM',
                  '₹${plan.amount}/year',
                ),
              ),
              Expanded(
                child: _buildBenefits(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, {bool showIcon = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (showIcon) ...[
              Icon(
                Icons.workspace_premium,
                size: 20,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 8),
            ],
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBenefits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TOP BENEFITS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        ...plan.benefits.map((benefit) => _buildBenefitItem(benefit)),
      ],
    );
  }

  Widget _buildBenefitItem(String benefit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: AppColors.successGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 10,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              benefit,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}