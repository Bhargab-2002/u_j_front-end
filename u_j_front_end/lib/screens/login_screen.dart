import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'personal_information_screen.dart';
import 'forget_password.dart';
import '../utils/widget_builder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final Map<String, dynamic> formData = {};

  // 🔹 LOAD JSON FROM ASSETS
  Future<Map<String, dynamic>> _loadLoginConfig() async {
    final jsonString =
        await rootBundle.loadString('assets/data/login_screen.json');

    // ✅ Convert LinkedMap → Map<String, dynamic>
    return Map<String, dynamic>.from(json.decode(jsonString));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<Map<String, dynamic>>(
      future: _loadLoginConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final config = snapshot.data!;

        // ✅ SAFE JSON CONVERSIONS
        final Map<String, dynamic> leftImageSection =
            Map<String, dynamic>.from(config["left_image_section"] ?? {});

        final Map<String, dynamic> loginSection =
            Map<String, dynamic>.from(config["login_section"] ?? {});

        final Map<String, dynamic> logo =
            Map<String, dynamic>.from(loginSection["logo"] ?? {});

        final List<Map<String, dynamic>> fields =
            (loginSection["fields"] as List? ?? [])
                .map((e) => Map<String, dynamic>.from(e))
                .toList();

        final String actionLabel =
            config["actions"]?["button"]?[0]?["primary"]?["label"] ?? "Login";

        // Get flex values from JSON
        final int leftImageFlex = leftImageSection["flex"] ?? 5;
        final int loginSectionFlex = loginSection["flex"] ?? 4;

        // Build image section widget
        final Widget? leftImageWidget =
            WidgetBuilderUtil.buildImageSection(imageSection: leftImageSection);

        return Scaffold(
          backgroundColor: const Color(0xFFF4F6FA),
          body: Center(
            child: Container(
              width: size.width * 0.9,
              constraints: BoxConstraints(
                minHeight: size.height * 0.85,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 🔹 LEFT IMAGE SECTION (FROM JSON)
                  if (leftImageWidget != null)
                    Expanded(
                      flex: leftImageFlex,
                      child: leftImageWidget,
                    ),

                  // RIGHT LOGIN FORM
                  Expanded(
                    flex: loginSectionFlex,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // LOGO (FROM JSON)
                            Center(
                              child: Container(
                                height: (logo["height"] ?? 72).toDouble(),
                                width: (logo["width"] ?? 72).toDouble(),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: logo["url"] != null
                                    ? Image.network(
                                        logo["url"],
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(Icons.image),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),

                            const SizedBox(height: 28),

                            // TITLE
                            Center(
                              child: Text(
                                loginSection["title"] ?? "",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),

                            const SizedBox(height: 36),

                            // 🔹 JSON LOOP → WIDGET BUILDER
                            ...fields
                                .where((f) => f["visible"] == true)
                                .map(
                                  (field) => WidgetBuilderUtil.buildField(
                                    field: field,
                                    obscurePassword: _obscurePassword,
                                    onTogglePassword: (value) {
                                      setState(() {
                                        _obscurePassword = value;
                                      });
                                    },
                                    onChanged: (value) {
                                      formData[field["key"]] = value;
                                    },
                                  ),
                                )
                                .toList(),

                            const SizedBox(height: 14),

                            // FORGET PASSWORD
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ForgetPasswordScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            // LOGIN BUTTON
                            WidgetBuilderUtil.buildPrimaryButton(
                              label: actionLabel,
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const PersonalInformationScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}