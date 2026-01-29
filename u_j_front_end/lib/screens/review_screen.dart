// lib/screen/review/review_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/review_model.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../widgets/plan_summary.dart';
import '../widgets/section_header.dart';
import '../widgets/detail_section.dart';
import '../widgets/document_list.dart';
import '../../components/layout/application_shell.dart';
import '../screens/personal_information_screen.dart';

class ReviewPage extends StatelessWidget {
  final ReviewModel reviewData;

  const ReviewPage({
    super.key,
    required this.reviewData,
  });

  // 🔹 LOAD JSON FROM ASSETS
  Future<Map<String, dynamic>> _loadReviewConfig() async {
    final jsonString =
    await rootBundle.loadString('assets/data/review.json');
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadReviewConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final config = snapshot.data!;
        final sections = config["sections"] as List;
        final actions = config["actions"];

        return ApplicationShell(
          currentStep: 4, // ✅ REVIEW STEP
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Container(
                width: 900,
                padding: const EdgeInsets.all(AppSpacing.xxl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(
                      config["title"],
                      config["subtitle"],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    PlanSummary(plan: reviewData.plan),
                    const SizedBox(height: AppSpacing.xxl),

                    // ================= A =================
                    SectionHeader(
                      label: sections[0]["sectionCode"],
                      title: sections[0]["title"],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    DetailSection(items: [
                      DetailItem(
                        label: 'FULL Name (as per Pan Card)',
                        value: reviewData.profile.fullName,
                      ),
                      DetailItem(
                        label: 'GENDER',
                        value: reviewData.profile.gender,
                      ),
                      DetailItem(
                        label: 'DATE OF BIRTH',
                        value: reviewData.profile.dateOfBirth,
                      ),
                    ]),

                    const SizedBox(height: AppSpacing.md),

                    DetailSection(items: [
                      DetailItem(
                        label: 'MOTHER\'S NAME',
                        value: reviewData.profile.motherName,
                      ),
                      DetailItem(
                        label: 'MARITUAL STATUS',
                        value: reviewData.profile.maritalStatus,
                      ),
                      DetailItem(
                        label: 'PAN NUMBER',
                        value: reviewData.profile.panNumber,
                      ),
                    ]),

                    const SizedBox(height: AppSpacing.xxl),

                    // ================= B =================
                    SectionHeader(
                      label: sections[1]["sectionCode"],
                      title: sections[1]["title"],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    _buildAddressSection(),
                    const SizedBox(height: AppSpacing.md),

                    DetailSection(items: [
                      DetailItem(
                        label: 'PINCODE',
                        value: reviewData.profile.pincode,
                      ),
                      DetailItem(
                        label: 'EMAIL ADDRESS',
                        value: reviewData.profile.email,
                      ),
                      DetailItem(
                        label: 'PHONE NUMBER',
                        value: reviewData.profile.phoneNumber,
                      ),
                    ]),

                    const SizedBox(height: AppSpacing.xxl),

                    // ================= C =================
                    SectionHeader(
                      label: sections[2]["sectionCode"],
                      title: sections[2]["title"],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    DetailSection(items: [
                      DetailItem(
                        label: 'ANNUAL INCOME BRACKET',
                        value: reviewData.profile.annualIncome,
                      ),
                      DetailItem(
                        label: 'OCCUPATION CATEGORY',
                        value: reviewData.profile.occupation,
                      ),
                      DetailItem(
                        label: 'ORGANATIONAL TYPE',
                        value: reviewData.profile.organizationType,
                      ),
                    ]),

                    const SizedBox(height: AppSpacing.md),

                    DetailSection(items: [
                      DetailItem(
                        label: 'NATIONALITY',
                        value: reviewData.profile.nationality,
                      ),
                      DetailItem(
                        label: 'RESIDENTIAL STATUS',
                        value: reviewData.profile.residentialStatus,
                      ),
                      DetailItem(
                        label: 'EDUCATIONAL LEVEL',
                        value: reviewData.profile.educationalLevel,
                      ),
                    ]),

                    const SizedBox(height: AppSpacing.xxl),

                    // ================= D =================
                    SectionHeader(
                      label: sections[3]["sectionCode"],
                      title: sections[3]["title"],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    DocumentList(
                      documents: reviewData.documents,
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    _buildActionButtons(
                      context,
                      actions["edit"]["label"],
                      actions["proceed"]["label"],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  // ================= ADDRESS =================

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CURRENT RESIDENTAL ADDRESS 1',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          reviewData.profile.address,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // ================= BUTTONS =================

  Widget _buildActionButtons(
      BuildContext context,
      String editLabel,
      String proceedLabel,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 48,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const PersonalInformationScreen(),
                ),
                    (route) => false,
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              side: const BorderSide(color: Colors.black),
              padding:
              const EdgeInsets.symmetric(horizontal: 32),
            ),
            child: Text(
              editLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Navigate to payment
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.successGreen,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 0,
              padding:
              const EdgeInsets.symmetric(horizontal: 32),
            ),
            child: Text(
              proceedLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
