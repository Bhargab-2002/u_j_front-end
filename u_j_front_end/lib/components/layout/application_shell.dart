import 'package:flutter/material.dart';
import '../../widgets/application_process_sidebar.dart';
import '../../components/layout/application_header.dart';

class ApplicationShell extends StatelessWidget {
  final int currentStep;
  final Widget child;

  const ApplicationShell({
    super.key,
    required this.currentStep,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: Column(
        children: [
          // 🔵 SINGLE SOURCE HEADER
          const ApplicationHeader(),

          // 🔵 MAIN CONTENT
          Expanded(
            child: Row(
              children: [
                ApplicationProcessSidebar(
                  currentStep: currentStep,
                ),
                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
