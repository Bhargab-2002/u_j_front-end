import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/application_process_sidebar.dart';
import 'upload_documents_screen.dart';
import '../utils/app_color.dart';
import '../components/personal_info/form_header.dart';
import '../components/personal_info/field_builders/continue_button.dart';
import '../components/personal_info/policy_section_header.dart';
import '../components/personal_info/field_builders/text_field_widget.dart';
import '../components/personal_info/field_builders/radio_field_widget.dart';
import '../components/personal_info/field_builders/dropdown_field_widget.dart';
import '../components/personal_info/field_builders/date_field_widget.dart';
import '../components/personal_info/field_builders/yes_no_field_widget.dart';
import '../../components/layout/application_header.dart';

class PolicyInformationScreen extends StatefulWidget {
  const PolicyInformationScreen({super.key});

  @override
  State<PolicyInformationScreen> createState() =>
      _PolicyInformationScreenState();
}

class _PolicyInformationScreenState
    extends State<PolicyInformationScreen> {
  final Map<String, dynamic> formData = {};
  String? gender;
  final TextEditingController dobController = TextEditingController();

  // 🔹 LOAD JSON FROM ASSETS
  Future<Map<String, dynamic>> _loadPolicyInfoConfig() async {
    final jsonString =
    await rootBundle.loadString('assets/data/policy_info.json');
    return json.decode(jsonString);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dobController.text =
        "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
        formData["dob"] = dobController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadPolicyInfoConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final config = snapshot.data!;
        final sections = config["sections"] as List;

        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: Column(
            children: [
              const ApplicationHeader(),

              Expanded(
                child: Row(
                  children: [
                    const ApplicationProcessSidebar(currentStep: 2),
                    Expanded(child: _buildForm(sections)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(List sections) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Center(
        child: Container(
          width: 780,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColor.cardBackground,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormHeader(
                title: 'Policy Holder Information',
                subtitle:
                'Provide comprehensive details of the Primary Policy Holder as per official documents',
              ),
              const SizedBox(height: 28),

              ...sections.map((section) => _buildSection(section)),

              const SizedBox(height: 36),

              ContinueButton(
                onPressed: () {
                  debugPrint("POLICY FORM DATA → $formData");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UploadDocumentsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section) {
    final fields = section["fields"] as List;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PolicySectionHeader(
          letter: section["sectionCode"],
          title: section["title"],
        ),
        const SizedBox(height: 16),

        ...fields.map((field) => _buildField(field)),

        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildField(Map<String, dynamic> field) {
    switch (field["type"]) {
      case "text":
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFieldWidget(
            label: field["label"],
            fieldKey: field["key"],
            formData: formData,
          ),
        );

      case "radio":
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: RadioFieldWidget(
            field: {
              "label": field["label"],
              "options": field["options"],
            },
            gender: gender,
            onGenderChanged: (v) => setState(() => gender = v),
            formData: formData,
          ),
        );

      case "dropdown":
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DropdownFieldWidget(
            label: field["label"],
            fieldKey: field["key"],
            options: List<String>.from(field["options"]),
            formData: formData,
            onChanged: (_) => setState(() {}),
          ),
        );

      case "date":
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DateFieldWidget(
            label: field["label"],
            fieldKey: field["key"],
            controller: dobController,
            placeholder: field["placeholder"] ?? 'DD/MM/YYYY',
            onTap: _pickDate,
          ),
        );

      case "boolean":
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: YesNoFieldWidget(
            label: field["label"],
            fieldKey: field["key"],
            formData: formData,
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
