class AdminCaseModel {
  final int id;
  final String title;
  final String description;
  final double targetAmount;
  final double collectedAmount;
  final String? coverImageUrl;
  final String beneficiaryName;
  final String categoryName;
  final String priority;
  final String status;

  AdminCaseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.collectedAmount,
    this.coverImageUrl,
    required this.beneficiaryName,
    required this.categoryName,
    required this.priority,
    required this.status,
  });

  factory AdminCaseModel.fromJson(Map<String, dynamic> json) {
    return AdminCaseModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      targetAmount: (json['targetAmount'] as num).toDouble(),
      collectedAmount: (json['collectedAmount'] as num).toDouble(),
      coverImageUrl: json['coverImageUrl'],
      beneficiaryName: json['beneficiaryName'] ?? '',
      categoryName: json['categoryName'] ?? '',
      priority: json['priority'] ?? '',
      status: json['status'] ?? '',
    );
  }

  // progress ratio clamped to 0.0–1.0
  double get progress =>
      targetAmount > 0 ? (collectedAmount / targetAmount).clamp(0.0, 1.0) : 0.0;

  bool get isActive => status == 'Active';
}
