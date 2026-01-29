import 'package:flutter/material.dart';

class DobAgeFieldWidget extends StatelessWidget {
  final TextEditingController dobController;
  final TextEditingController ageController;
  final VoidCallback onDateSelect;

  const DobAgeFieldWidget({
    super.key,
    required this.dobController,
    required this.ageController,
    required this.onDateSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('DATE OF BIRTH'),
                TextFormField(
                  controller: dobController,
                  readOnly: true,
                  onTap: onDateSelect,
                  decoration: _inputDecoration(
                    icon: Icons.calendar_today_outlined,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('AGE'),
                TextFormField(
                  controller: ageController,
                  enabled: false,
                  decoration: _disabledDecoration(),
                ),
              ],
            ),
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

  InputDecoration _disabledDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFE6E6E6),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      isDense: true,
    );
  }
}