import 'package:flutter/material.dart';
import 'field_builders/text_field_widget.dart';
import 'field_builders/radio_field_widget.dart';
import 'field_builders/dob_age_field_widget.dart';
import 'field_builders/yes_no_field_widget.dart';

class FormSection extends StatelessWidget {
  final Map<String, dynamic> section;
  final Map<String, dynamic> formData;
  final String? gender;
  final Function(String?) onGenderChanged;
  final TextEditingController dobController;
  final TextEditingController ageController;
  final VoidCallback onDateSelect;

  const FormSection({
    super.key,
    required this.section,
    required this.formData,
    required this.gender,
    required this.onGenderChanged,
    required this.dobController,
    required this.ageController,
    required this.onDateSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(section['title']),
        ...section['fields']
            .map<Widget>((field) => _buildField(field))
            .toList(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildField(Map<String, dynamic> field) {
    switch (field['type']) {
      case 'text':
      case 'number':
        return TextFieldWidget(
          label: field['label'],
          fieldKey: field['key'],
          formData: formData,
        );
      case 'radio':
        return RadioFieldWidget(
          field: field,
          gender: gender,
          onGenderChanged: onGenderChanged,
          formData: formData,
        );
      case 'dob_age':
        return DobAgeFieldWidget(
          dobController: dobController,
          ageController: ageController,
          onDateSelect: onDateSelect,
        );
      case 'boolean':
        return YesNoFieldWidget(
          label: field['label'],
          fieldKey: field['key'],
          formData: formData,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}