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
    required this.priority,
    required this.status,
    required this.charityId,
    required this.adminId,
    required this.isFeatured,
    this.location,
    this.endDate,
  });

  /// Converts the model to form fields for multipart/form-data submission.
  Map<String, String> toFormFields() {
    final fields = <String, String>{
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
    };

    if (location != null && location!.isNotEmpty) {
      fields['Location'] = location!;
    }
    if (endDate != null && endDate!.isNotEmpty) {
      fields['EndDate'] = endDate!;
    }

    return fields;
  }

  factory CreateCaseRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateCaseRequestModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      beneficiaryName: json['beneficiaryName'] as String? ?? '',
      age: (json['age'] as num?)?.toInt() ?? 0,
      targetAmount: (json['targetAmount'] as num?)?.toDouble() ?? 0.0,
      categoryId: (json['categoryId'] as num?)?.toInt() ?? 0,
      priority: json['priority'] as String? ?? 'Normal',
      status: json['status'] as String? ?? 'Active',
      charityId: (json['charityId'] as num?)?.toInt() ?? 0,
      adminId: (json['adminId'] as num?)?.toInt() ?? 0,
      isFeatured: json['isFeatured'] as bool? ?? false,
      location: json['location'] as String?,
      endDate: json['endDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'beneficiaryName': beneficiaryName,
      'age': age,
      'targetAmount': targetAmount,
      'categoryId': categoryId,
      'priority': priority,
      'status': status,
      'charityId': charityId,
      'adminId': adminId,
      'isFeatured': isFeatured,
      if (location != null) 'location': location,
      if (endDate != null) 'endDate': endDate,
    };
  }
}
