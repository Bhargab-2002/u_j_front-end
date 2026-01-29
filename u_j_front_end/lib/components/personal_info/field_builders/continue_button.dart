import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ContinueButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 160,
        height: 44,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed, // ✅ now nullable
          child: const Text('CONTINUE'),
        ),
      ),
    );
  }
}
