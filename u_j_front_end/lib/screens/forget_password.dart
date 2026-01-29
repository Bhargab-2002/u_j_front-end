import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final Map<String, dynamic> formData = {};

  // 🔹 LOAD JSON FROM ASSETS
  Future<Map<String, dynamic>> _loadForgetPasswordConfig() async {
    final jsonString =
    await rootBundle.loadString('assets/data/forget_password.json');
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<Map<String, dynamic>>(
      future: _loadForgetPasswordConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final config = snapshot.data!;
        final fields = config["fields"] as List;

        return Scaffold(
          backgroundColor: const Color(0xFFF4F6FA),
          body: Center(
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.85,
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
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            '/Users/bhargabdas/FlutterDev/res/images/3814907.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.white.withOpacity(0.01),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // RIGHT FORM
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // LOGO (UNCHANGED)
                          Center(
                            child: Container(
                              height: 72,
                              width: 72,
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
                              child: Image.asset(
                                '/Users/bhargabdas/FlutterDev/res/images/IMG_6821.jpg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // TITLE (FROM JSON)
                          Center(
                            child: Text(
                              config["title"],
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Center(
                            child: Text(
                              config["subtitle"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),

                          const SizedBox(height: 36),

                          // 🔹 FIELD FROM JSON
                          ...fields
                              .map((field) => _buildField(field))
                              ,

                          const SizedBox(height: 30),

                          // RESET BUTTON (TEXT FROM JSON)
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: send reset link
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF143A6E),
                                elevation: 6,
                                shadowColor:
                                Colors.black.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(
                                config["cta"]["primary"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // BACK TO LOGIN (TEXT FROM JSON)
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                config["cta"]["secondary"],
                                style: const TextStyle(
                                  color: Color(0xFF143A6E),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
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

  // ================= FIELD BUILDER =================

  Widget _buildField(Map<String, dynamic> field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field["label"],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (v) => formData[field["key"]] = v,
          decoration: InputDecoration(
            hintText: field["placeholder"],
            prefixIcon: const Icon(Icons.email_outlined),
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
      ],
    );
  }
}
