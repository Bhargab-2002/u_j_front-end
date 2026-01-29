import 'package:flutter/material.dart';

class ApplicationProcessSidebar extends StatelessWidget {
  final int currentStep;

  const ApplicationProcessSidebar({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FB),
        border: Border(
          right: BorderSide(color: Color(0xFFE4E6EB)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'APPLICATION PROCESS',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 24),

          _stepItem('Personal Details', 0),
          _stepItem('Sum Insured', 1),
          _stepItem('Policy Holder Details', 2),
          _stepItem('Upload Documents', 3),
          _stepItem('Review', 4),
          _stepItem('Payment', 5),
        ],
      ),
    );
  }

  Widget _stepItem(String title, int stepIndex) {
    final bool isCompleted = stepIndex < currentStep;
    final bool isActive = stepIndex == currentStep;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: isActive
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ]
            : [],
      ),
      child: Row(
        children: [
          // 🔹 STEP ICON
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? Colors.black
                  : isActive
                  ? Colors.white
                  : Colors.transparent,
              border: Border.all(
                color: isCompleted || isActive
                    ? Colors.black
                    : Colors.grey.shade400,
                width: 1.5,
              ),
            ),
            child: isCompleted
                ? const Icon(
              Icons.check,
              size: 12,
              color: Colors.white,
            )
                : isActive
                ? Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            )
                : null,
          ),

          const SizedBox(width: 12),

          // 🔹 STEP TITLE
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive
                    ? FontWeight.w600
                    : isCompleted
                    ? FontWeight.w500
                    : FontWeight.normal,
                color: isCompleted
                    ? Colors.black
                    : isActive
                    ? Colors.black
                    : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
