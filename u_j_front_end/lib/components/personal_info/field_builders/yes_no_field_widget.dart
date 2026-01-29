import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';

class YesNoFieldWidget extends StatefulWidget {
  final String label;
  final String fieldKey;
  final Map<String, dynamic> formData;

  const YesNoFieldWidget({
    super.key,
    required this.label,
    required this.fieldKey,
    required this.formData,
  });

  @override
  State<YesNoFieldWidget> createState() => _YesNoFieldWidgetState();
}

class _YesNoFieldWidgetState extends State<YesNoFieldWidget> {
  @override
  Widget build(BuildContext context) {
    bool isYes = widget.formData[widget.fieldKey] ?? true;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.sectionBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(child: Text(widget.label)),
          Row(
            children: [
              _yesNoButton(
                label: 'Yes',
                selected: isYes,
                onTap: () {
                  setState(() {
                    widget.formData[widget.fieldKey] = true;
                  });
                },
              ),
              _yesNoButton(
                label: 'No',
                selected: !isYes,
                onTap: () {
                  setState(() {
                    widget.formData[widget.fieldKey] = false;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _yesNoButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColor.kPurpleLight : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? AppColor.kPurple : Colors.black,
          ),
        ),
      ),
    );
  }
}