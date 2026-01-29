// lib/models/review_model.dart
// lib/models/review_model.dart
import 'plan_model.dart';
import 'user_profile_model.dart';
import 'document_model.dart';


class ReviewModel {
  final Plan plan;
  final UserProfileModel profile;
  final List<DocumentModel> documents;

  ReviewModel({
    required this.plan,
    required this.profile,
    required this.documents,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      plan: Plan.fromJson(json['plan'] as Map<String, dynamic>),
      profile: UserProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      documents: (json['documents'] as List)
          .map((doc) => DocumentModel.fromJson(doc as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan': plan.toJson(),
      'profile': profile.toJson(),
      'documents': documents.map((doc) => doc.toJson()).toList(),
    };
  }

  // Sample data for testing
  static ReviewModel getSampleData() {
    return ReviewModel(
      plan: Plan(
        premiumType: 'GOLD',
        amount: '8700',
        benefits: [
          '80% bill amount paid',
          'Get up to 25k tax deduction',
          'Standard waiting period',
        ],
      ),
      profile: UserProfileModel(
        fullName: 'Jonathan Alexendra',
        gender: 'Male',
        dateOfBirth: '01/01/1996',
        motherName: 'Mary Alexendra',
        maritalStatus: 'Single',
        panNumber: 'ABCDE1234F',
        address: 'Flat-420, Skyline Aparments, MG Road, Bangalore, KA500130',
        pincode: '500130',
        email: 'john123@gmail.com',
        phoneNumber: '7003456789',
        annualIncome: '₹10L',
        occupation: 'Salaried',
        organizationType: 'Private Limited',
        nationality: 'Indian',
        residentialStatus: 'Individual',
        educationalLevel: 'Post Graduate',
      ),
      documents: [
        DocumentModel(name: 'Hospitalization Record', fileName: 'image.jpg'),
        DocumentModel(name: 'Addition Records', fileName: 'image.jpg'),
        DocumentModel(name: 'Doctor Certificate', fileName: 'image.jpg'),
      ],
    );
  }
}
