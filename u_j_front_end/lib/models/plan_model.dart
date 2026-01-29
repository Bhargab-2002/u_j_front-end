// lib/models/plan_model.dart

class Plan {
  final String premiumType;
  final String amount;
  final List<String> benefits;

  Plan({
    required this.premiumType,
    required this.amount,
    required this.benefits,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      premiumType: json['premiumType'] as String,
      amount: json['amount'] as String,
      benefits: List<String>.from(json['benefits'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'premiumType': premiumType,
      'amount': amount,
      'benefits': benefits,
    };
  }
}
