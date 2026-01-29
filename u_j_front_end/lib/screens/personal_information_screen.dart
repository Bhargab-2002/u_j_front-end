import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/application_process_sidebar.dart';
import '../utils/app_color.dart';
import '../components/personal_info/form_header.dart';
import '../components/personal_info/form_section.dart';
import '../components/personal_info/field_builders/continue_button.dart';
import '../../components/layout/application_header.dart';
import 'sum_insure.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {
  final Map<String, dynamic> formData = {};
  String? gender;

  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // 🔹 LOAD JSON FROM ASSETS
  Future<Map<String, dynamic>> _loadPersonalInfoConfig() async {
    final jsonString =
    await rootBundle.loadString('assets/data/personal_info.json');
    return json.decode(jsonString);
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final today = DateTime.now();
      int age = today.year - picked.year;
      if (today.month < picked.month ||
          (today.month == picked.month && today.day < picked.day)) {
        age--;
      }

      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
        _ageController.text = age.toString();
        formData["dob"] = _dobController.text;
        formData["age"] = age;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadPersonalInfoConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final config = snapshot.data!;

        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: Column(
            children: [
              const ApplicationHeader(),

              Expanded(
                child: Row(
                  children: [
                    const ApplicationProcessSidebar(currentStep: 0),
                    Expanded(child: _buildForm(config)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(Map<String, dynamic> config) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Container(
          width: 720,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColor.cardBackground,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormHeader(
                title: config["title"],
                subtitle: config["subtitle"],
              ),
              const SizedBox(height: 26),
              ...config["sections"]
                  .map<Widget>(
                    (section) => FormSection(
                  section: section,
                  formData: formData,
                  gender: gender,
                  onGenderChanged: (v) => setState(() => gender = v),
                  dobController: _dobController,
                  ageController: _ageController,
                  onDateSelect: _selectDate,
                ),
              )
                  .toList(),
              const SizedBox(height: 36),
              ContinueButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InsurancePage(),
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
}
