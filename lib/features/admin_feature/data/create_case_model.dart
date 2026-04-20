class CreateCaseRequestModel {
  final String title;
  final String description;
  final String beneficiaryName;
  final int age;
  final double targetAmount;
  final int categoryId;
  final String priority;
  final String status;
  final int charityId;
  final int adminId;
  final bool isFeatured;
  final String? location;
  final String? endDate;
 
  CreateCaseRequestModel({
    required this.title,
    required this.description,
    required this.beneficiaryName,
    required this.age,
    required this.targetAmount,
    required this.categoryId,
    required this.charityId,
    required this.adminId,
    this.priority = 'Normal',
    this.status = 'Active',
    this.isFeatured = false,
    this.location,
    this.endDate,
  });
 
  /// Returns a flat Map<String, String> suitable for multipart form-data.
  /// All values must be strings in multipart.
  Map<String, String> toFormFields() {
    return {
      'Title': title,
      'Description': description,
      'BeneficiaryName': beneficiaryName,
      'Age': age.toString(),
      'TargetAmount': targetAmount.toString(),
      'CategoryId': categoryId.toString(),
      'Priority': priority,
      'Status': status,
      'CharityId': charityId.toString(),
      'AdminId': adminId.toString(),
      'IsFeatured': isFeatured.toString(),
      if (location != null) 'Location': location!,
      if (endDate != null) 'EndDate': endDate!,
    };
  }
}