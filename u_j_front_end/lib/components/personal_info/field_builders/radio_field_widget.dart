import 'package:flutter/material.dart';

class RadioFieldWidget extends StatelessWidget {
  final Map field;
  final String? gender;
  final Function(String?) onGenderChanged;
  final Map<String, dynamic> formData;

  const RadioFieldWidget({
    super.key,
    required this.field,
    required this.gender,
    required this.onGenderChanged,
    required this.formData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(field['label']),
          Row(
            children: field['options'].map<Widget>((opt) {
              return Row(
                children: [
                  Radio<String>(
                    value: opt,
                    groupValue: gender,
                    onChanged: (v) {
                      onGenderChanged(v);
                      formData['gender'] = v;
                    },
                  ),
                  Text(opt),
                  const SizedBox(width: 12),
                ],
              );
            }).toList(),
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
}