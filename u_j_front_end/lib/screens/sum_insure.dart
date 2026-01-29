import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/plaincard.dart';
import '../screens/policy_information_screen.dart';
import '../components/layout/application_shell.dart';

class InsurancePage extends StatefulWidget {
  const InsurancePage({super.key});

  @override
  State<InsurancePage> createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {
  late String selectedPlan;
  late Map<String, int> planPrices;

  bool _initialized = false;

  // 🔹 LOAD JSON FROM ASSETS
  Future<Map<String, dynamic>> _loadSumInsuredConfig() async {
    final jsonString =
    await rootBundle.loadString('assets/data/sum_insured.json');
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadSumInsuredConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final config = snapshot.data!;
        final plans = config["plans"] as List;
        final features = config["features"] as List;

        // 🔹 INIT STATE ONCE (same logic as before)
        if (!_initialized) {
          selectedPlan = plans.first["title"];
          planPrices = {
            for (var plan in plans)
              plan["title"]: plan["price"] as int,
          };
          _initialized = true;
        }

        return ApplicationShell(
          currentStep: 1, // Sum Insure step
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // TITLE (FROM JSON)
                      Text(
                        config["title"],
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // SUBTITLE (FROM JSON)
                      Text(
                        config["subtitle"],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// INCLUDED FEATURES (FROM JSON)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: Colors.blue.shade200),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_hospital,
                                color: Colors.blue),
                            const SizedBox(width: 10),
                            Text(features[0]),
                            const SizedBox(width: 20),
                            const Icon(Icons.apartment,
                                color: Colors.blue),
                            const SizedBox(width: 10),
                            Text(features[1]),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// PLANS (FROM JSON)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: plans.map<Widget>((plan) {
                          final bool isOrange =
                              plan["badgeColor"] == "orange";

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12),
                            child: PlanCard(
                              title: plan["title"],
                              highlight:
                              selectedPlan == plan["title"],
                              badgeText: plan["badgeText"],
                              badgeColor: isOrange
                                  ? Colors.orange.shade500
                                  : Colors.transparent,
                              onTap: () => setState(
                                    () => selectedPlan = plan["title"],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),

              /// BOTTOM BAR (UNCHANGED)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${planPrices[selectedPlan]} /mo (including 18% GST)",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const PolicyInformationScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Proceed with $selectedPlan Plan",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
