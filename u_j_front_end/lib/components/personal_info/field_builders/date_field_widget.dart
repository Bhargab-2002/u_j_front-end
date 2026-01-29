import 'package:flutter/material.dart';

class DateFieldWidget extends StatelessWidget {
  final String label;
  final String fieldKey;
  final TextEditingController controller;
  final VoidCallback onTap;
  final String placeholder;

  const DateFieldWidget({
    super.key,
    required this.label,
    required this.fieldKey,
    required this.controller,
    required this.onTap,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          decoration: _inputDecoration(
            hint: placeholder,
            icon: Icons.calendar_today_outlined,
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint, IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: icon != null ? Icon(icon, size: 18) : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}