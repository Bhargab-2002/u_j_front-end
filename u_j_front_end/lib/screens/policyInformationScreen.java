import 'package:flutter/material.dart';
import '../widgets/application_process_sidebar.dart';
import 'upload_documents_screen.dart';
import '../utils/app_color.dart';
import '../components/personal_info/form_header.dart';
import '../components/personal_info/continue_button.dart';
import '../components/personal_info/policy_section_header.dart';
import '../components/personal_info/field_builders/text_field_widget.dart';
import '../components/personal_info/field_builders/radio_field_widget.dart';
import '../components/personal_info/field_builders/dropdown_field_widget.dart';
import '../components/personal_info/field_builders/date_field_widget.dart';
import '../components/personal_info/field_builders/yes_no_field_widget.dart';

class PolicyInformationScreen extends StatefulWidget {
  const PolicyInformationScreen({super.key});

  @override
  State<PolicyInformationScreen> createState() =>
      _PolicyInformationScreenState();
}

class _PolicyInformationScreenState extends State<PolicyInformationScreen> {
  final Map<String, dynamic> formData = {};
  String? gender;
  final TextEditingController dobController = TextEditingController();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
        formData["dob"] = dobController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Row(
              children: [
                const ApplicationProcessSidebar(currentStep: 1),
                Expanded(child: _buildForm()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColor.headerBlue,
      child: Row(
        children: [
          Image.asset(
            '/Users/bhargabdas/FlutterDev/project/ofc/assets/hlogo.webp',
            height: 36,
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
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
                subtitle: 'Provide comprehensive details of the Primary Policy Holder as per official documents',
              ),
              const SizedBox(height: 28),
              
              // ================= SECTION A =================
              _buildSectionA(),
              const SizedBox(height: 28),

              // ================= SECTION B =================
              _buildSectionB(),
              const SizedBox(height: 28),

              // ================= SECTION C =================
              _buildSectionC(),
              const SizedBox(height: 28),

              // ================= SECTION D =================
              _buildSectionD(),
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

  // ================= SECTION A: Preliminary Details =================
  Widget _buildSectionA() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PolicySectionHeader(
          letter: 'A',
          title: 'Preliminary Details',
        ),
        
        TextFieldWidget(
          label: 'FULL Name (as per Pan Card)',
          fieldKey: 'fullName',
          formData: formData,
        ),
        const SizedBox(height: 16),

        RadioFieldWidget(
          field: const {
            'label': 'SELECT YOUR GENDER',
            'options': ['Male', 'Female', 'Others']
          },
          gender: gender,
          onGenderChanged: (v) => setState(() => gender = v),
          formData: formData,
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: DateFieldWidget(
                label: 'DATE OF BIRTH (as per Pan Card)',
                fieldKey: 'dob',
                controller: dobController,
                onTap: _pickDate,
                placeholder: 'DD/MM/YYYY',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: DropdownFieldWidget(
                label: 'MARITUAL STATUS',
                fieldKey: 'maritalStatus',
                options: const ['Single', 'Married', 'Divorced', 'Widowed'],
                formData: formData,
                onChanged: (v) => setState(() {}),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                label: "MOTHER'S NAME",
                fieldKey: 'motherName',
                formData: formData,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: TextFieldWidget(
                label: 'PAN NUMBER',
                fieldKey: 'panNumber',
                formData: formData,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ================= SECTION B: Communication Details =================
  Widget _buildSectionB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PolicySectionHeader(
          letter: 'B',
          title: 'Communication Details',
        ),
        
        TextFieldWidget(
          label: 'CURRENT RESIDENTIAL ADDRESS 1',
          fieldKey: 'address1',
          formData: formData,
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                label: 'CURRENT RESIDENTIAL ADDRESS 2',
                fieldKey: 'address2',
                formData: formData,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: TextFieldWidget(
                label: 'PINCODE',
                fieldKey: 'pincode',
                formData: formData,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        TextFieldWidget(
          label: 'EMAIL ADDRESS',
          fieldKey: 'email',
          formData: formData,
        ),
      ],
    );
  }

  // ================= SECTION C: Professional Details =================
  Widget _buildSectionC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PolicySectionHeader(
          letter: 'C',
          title: 'Professional Details',
        ),
        
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: DropdownFieldWidget(
                  label: 'ANNUAL INCOME BRACKET',
                  fieldKey: 'annualIncome',
                  options: const [
                    '0 - 2.5 Lakhs',
                    '2.5 - 5 Lakhs',
                    '5 - 15 Lakhs',
                    '15 - 20 Lakhs',
                    '20 - 30 Lakhs',
                    'Above 30 Lakhs',
                  ],
                  formData: formData,
                  onChanged: (v) => setState(() {}),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: DropdownFieldWidget(
                  label: 'OCCUPATION CATEGORY',
                  fieldKey: 'occupation',
                  options: const [
                    'Student',
                    'Salaried',
                    'Retired',
                    'Business Owner',
                    'Housewife',
                    'Others',
                  ],
                  formData: formData,
                  onChanged: (v) => setState(() {}),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: DropdownFieldWidget(
                  label: 'ORGANATIONAL TYPE',
                  fieldKey: 'organizationType',
                  options: const [
                    'Government',
                    'Private Limited',
                    'Public Limited',
                    'Trust',
                    'Other',
                  ],
                  formData: formData,
                  onChanged: (v) => setState(() {}),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: DropdownFieldWidget(
                  label: 'NATIONALITY',
                  fieldKey: 'nationality',
                  options: const ['Indian'],
                  formData: formData,
                  onChanged: (v) => setState(() {}),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: DropdownFieldWidget(
                  label: 'RESIDENTIAL STATUS',
                  fieldKey: 'residentialStatus',
                  options: const ['NRI', 'Resident Indian'],
                  formData: formData,
                  onChanged: (v) => setState(() {}),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: DropdownFieldWidget(
                  label: 'EDUCATIONAL LEVEL',
                  fieldKey: 'educationLevel',
                  options: const [
                    'Post Graduate',
                    'Graduate',
                    'Matriculation',
                    'Under Matriculation',
                    'Other',
                  ],
                  formData: formData,
                  onChanged: (v) => setState(() {}),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ================= SECTION D: Regulatory Declarations =================
  Widget _buildSectionD() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PolicySectionHeader(
          letter: 'D',
          title: 'Regulatory Declarations',
        ),
        
        YesNoFieldWidget(
          label: 'Are you a Politically Exposed Person (PEP) or family member/close relative/associate of PEP?',
          fieldKey: 'pep',
          formData: formData,
        ),
        YesNoFieldWidget(
          label: 'Is your total aggregate premium across all products with HDFC ERGO General Insurance Company Limited more than INR 2 lakhs?',
          fieldKey: 'premium2Lakhs',
          formData: formData,
        ),
        YesNoFieldWidget(
          label: 'Do you have investable assets for more than INR 5 crores?',
          fieldKey: 'assets5Crores',
          formData: formData,
        ),
        YesNoFieldWidget(
          label: 'Is your total aggregate premium across all retail products with HDFC ERGO General Insurance Company Limited INR 30 lakhs or more',
          fieldKey: 'premium30Lakhs',
          formData: formData,
        ),
      ],
    );
  }
}