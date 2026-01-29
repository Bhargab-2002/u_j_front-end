// lib/models/user_profile_model.dart
class UserProfileModel {
  final String fullName;
  final String gender;
  final String dateOfBirth;
  final String motherName;
  final String maritalStatus;
  final String panNumber;
  final String address;
  final String pincode;
  final String email;
  final String phoneNumber;
  final String annualIncome;
  final String occupation;
  final String organizationType;
  final String nationality;
  final String residentialStatus;
  final String educationalLevel;

  UserProfileModel({
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
    required this.motherName,
    required this.maritalStatus,
    required this.panNumber,
    required this.address,
    required this.pincode,
    required this.email,
    required this.phoneNumber,
    required this.annualIncome,
    required this.occupation,
    required this.organizationType,
    required this.nationality,
    required this.residentialStatus,
    required this.educationalLevel,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      fullName: json['fullName'] as String,
      gender: json['gender'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      motherName: json['motherName'] as String,
      maritalStatus: json['maritalStatus'] as String,
      panNumber: json['panNumber'] as String,
      address: json['address'] as String,
      pincode: json['pincode'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      annualIncome: json['annualIncome'] as String,
      occupation: json['occupation'] as String,
      organizationType: json['organizationType'] as String,
      nationality: json['nationality'] as String,
      residentialStatus: json['residentialStatus'] as String,
      educationalLevel: json['educationalLevel'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'motherName': motherName,
      'maritalStatus': maritalStatus,
      'panNumber': panNumber,
      'address': address,
      'pincode': pincode,
      'email': email,
      'phoneNumber': phoneNumber,
      'annualIncome': annualIncome,
      'occupation': occupation,
      'organizationType': organizationType,
      'nationality': nationality,
      'residentialStatus': residentialStatus,
      'educationalLevel': educationalLevel,
    };
  }
}
