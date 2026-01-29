import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'personal_information_screen.dart';
import 'forget_password.dart';

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

    // IMPORTANT: convert LinkedMap → Map<String, dynamic>
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
        final Map<String, dynamic> loginSection =
            Map<String, dynamic>.from(config["login_section"] ?? {});

        final Map<String, dynamic> logo =
            Map<String, dynamic>.from(loginSection["logo"] ?? {});

        final List<Map<String, dynamic>> fields =
            (loginSection["fields"] as List? ?? [])
                .map((e) => Map<String, dynamic>.from(e))
                .toList();

        final String actionLabel =
            config["actions"]?["button"]?[0]?["primary"]?["label"] ??
                "Login";

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
                  // LEFT IMAGE SECTION (UNCHANGED)
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                      ),
                      child: Image.asset(
                        '/Users/bhargabdas/FlutterDev/res/images/IMG_6822.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // RIGHT LOGIN FORM
                  Expanded(
                    flex: 4,
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
                                      color:
                                          Colors.black.withOpacity(0.1),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: logo["url"] != null
                                    ? Image.network(
                                        logo["url"],
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (_, __, ___) =>
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

                            // 🔹 FIELDS (VISIBLE ONLY)
                            ...fields
                                .where((f) => f["visible"] == true)
                                .map(_buildField)
                                .toList(),

                            const SizedBox(height: 14),

                            // FORGET PASSWORD (UNCHANGED)
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
                                  style:
                                      TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            // LOGIN BUTTON
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const PersonalInformationScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF143A6E),
                                  elevation: 6,
                                  shadowColor:
                                      Colors.black.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),
                                ),
                                child: Text(
                                  actionLabel,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
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

  // ================= ICON RESOLVER =================

  IconData _resolveIcon(String? iconName) {
    switch (iconName) {
      case "phone":
        return Icons.phone;
      case "lock":
        return Icons.lock;
      case "email":
        return Icons.email;
      case "user":
        return Icons.person;
      default:
        return Icons.text_fields; // safe fallback
    }
  }

  // ================= FIELD BUILDER =================

  Widget _buildField(Map<String, dynamic> field) {
    final bool isPassword = field["field_type"] == "password";
    final bool isPhone = field["key"] == "phone";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field["label"] ?? "",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType:
              isPhone ? TextInputType.phone : TextInputType.text,
          obscureText: isPassword ? _obscurePassword : false,
          onChanged: (v) => formData[field["key"]] = v,
          decoration: InputDecoration(
            hintText: field["placeHolder"] ?? "",
            prefixIcon: Icon(
              _resolveIcon(field["icon"]),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  )
                : null,
            filled: true,
            fillColor: const Color(0xFFF7F8FA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}
