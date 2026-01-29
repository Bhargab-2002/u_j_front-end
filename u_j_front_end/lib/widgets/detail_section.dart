
import 'package:flutter/material.dart';
import '../../../theme/spacing.dart';

class DetailItem {
  final String label;
  final String value;

  DetailItem({required this.label, required this.value});
}

class DetailSection extends StatelessWidget {
  final List<DetailItem> items;

  const DetailSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: items.map((item) => _buildDetailItem(item, true)).toList(),
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Expanded(child: _buildDetailItem(item, false)))
              .toList(),
        );
      },
    );
  }

  Widget _buildDetailItem(DetailItem item, bool fullWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: fullWidth ? AppSpacing.md : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

