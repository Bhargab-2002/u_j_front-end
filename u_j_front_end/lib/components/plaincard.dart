import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final bool highlight;
  final String? badgeText;
  final Color badgeColor;
  final VoidCallback? onTap;

  const PlanCard({
    super.key,
    required this.title,
    this.highlight = false,
    this.badgeText,
    this.badgeColor = Colors.green,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: highlight ? Colors.blue : Colors.grey.shade300,
            width: highlight ? 2 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),
            const Text("Essential Protection"),

            const SizedBox(height: 16),

            _benefit("80% bill amount paid"),
            _benefit("Get up to 25k tax deduction"),
            _benefit("Standard waiting period"),

            const SizedBox(height: 16),

            // ✅ RESERVED BADGE SPACE (KEY FIX)
            SizedBox(
              height: 32,
              child: badgeText == null
                  ? const SizedBox.shrink()
                  : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: badgeColor.withAlpha((0.1 * 255).round()),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: badgeColor),
                ),
                child: Text(
                  badgeText!,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "SEE ALL THE BENEFITS",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _benefit(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
