class Profile {
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

  Profile({
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

  /// ✅ Optional helper for testing / temporary navigation
  static Profile mock() {
    return Profile(
      fullName: 'John Doe',
      gender: 'Male',
      dateOfBirth: '01-01-1995',
      motherName: 'Jane Doe',
      maritalStatus: 'Single',
      panNumber: 'ABCDE1234F',
      address: '123, Demo Street, Guwahati, Assam',
      pincode: '781001',
      email: 'john.doe@email.com',
      phoneNumber: '9876543210',
      annualIncome: '5–10 LPA',
      occupation: 'Software Engineer',
      organizationType: 'Private',
      nationality: 'Indian',
      residentialStatus: 'Resident',
      educationalLevel: 'Graduate',
    );
  }
}
