import 'package:flutter/material.dart';
import '../widgets/base_layout.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      step: 5,
      title: 'Payment',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Payment Method',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          _paymentOption(
            icon: Icons.credit_card,
            title: 'Credit / Debit Card',
          ),

          _paymentOption(
            icon: Icons.account_balance_wallet,
            title: 'UPI',
          ),

          _paymentOption(
            icon: Icons.account_balance,
            title: 'Net Banking',
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                _showSuccessDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Pay Now',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔧 Payment option tile
  Widget _paymentOption({
    required IconData icon,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // 🔔 Success dialog
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text(
            'Your insurance policy has been successfully purchased.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                      (route) => route.isFirst,
                );
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
