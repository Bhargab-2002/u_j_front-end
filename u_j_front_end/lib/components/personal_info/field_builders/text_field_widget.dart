import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String fieldKey;
  final Map<String, dynamic> formData;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.fieldKey,
    required this.formData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label),
          TextFormField(
            onChanged: (v) => formData[fieldKey] = v,
            decoration: _inputDecoration(),
          ),
        ],
      ),
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

  InputDecoration _inputDecoration({IconData? icon}) {
    return InputDecoration(
      suffixIcon: icon != null ? Icon(icon, size: 18) : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}