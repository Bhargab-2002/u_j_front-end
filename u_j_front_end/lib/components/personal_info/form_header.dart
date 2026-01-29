import 'package:flutter/material.dart';
import '../../utils/app_color.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const FormHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: AppColor.labelGrey,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}