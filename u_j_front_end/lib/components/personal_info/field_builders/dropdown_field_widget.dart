import 'package:flutter/material.dart';

class DropdownFieldWidget extends StatelessWidget {
  final String label;
  final String fieldKey;
  final List<String> options;
  final Map<String, dynamic> formData;
  final Function(String?) onChanged;

  const DropdownFieldWidget({
    super.key,
    required this.label,
    required this.fieldKey,
    required this.options,
    required this.formData,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        DropdownButtonFormField<String>(
          initialValue: formData[fieldKey],
          hint: const Text('Select'),
          items: options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            formData[fieldKey] = v;
            onChanged(v);
          },
          decoration: _inputDecoration(),
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

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}