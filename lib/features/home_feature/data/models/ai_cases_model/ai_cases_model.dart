import 'package:equatable/equatable.dart';

class AiCasesModel extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? location;
  final int? age;
  final int? targetAmount;
  final int? collectedAmount;
  final dynamic coverImageUrl;
  final String? beneficiaryName;
  final dynamic endDate;
  final bool? isFeatured;
  final bool? isDeleted;
  final dynamic donorsCount;
  final int? categoryId;
  final String? categoryName;
  final String? priority;
  final String? status;
  final DateTime? createdAt;
  final int? charityId;
  final String? charityName;
  final int? adminId;
  final List<dynamic>? attachments;

  const AiCasesModel({
    this.id,
    this.title,
    this.description,
    this.location,
    this.age,
    this.targetAmount,
    this.collectedAmount,
    this.coverImageUrl,
    this.beneficiaryName,
    this.endDate,
    this.isFeatured,
    this.isDeleted,
    this.donorsCount,
    this.categoryId,
    this.categoryName,
    this.priority,
    this.status,
    this.createdAt,
    this.charityId,
    this.charityName,
    this.adminId,
    this.attachments,
  });

  factory AiCasesModel.fromJson(Map<String, dynamic> json) => AiCasesModel(
    id: json['id'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    location: json['location'] as String?,
    age: json['age'] as int?,
    targetAmount: json['targetAmount'] as int?,
    collectedAmount: json['collectedAmount'] as int?,
    coverImageUrl: json['coverImageUrl'] as dynamic,
    beneficiaryName: json['beneficiaryName'] as String?,
    endDate: json['endDate'] as dynamic,
    isFeatured: json['isFeatured'] as bool?,
    isDeleted: json['isDeleted'] as bool?,
    donorsCount: json['donorsCount'] as dynamic,
    categoryId: json['categoryId'] as int?,
    categoryName: json['categoryName'] as String?,
    priority: json['priority'] as String?,
    status: json['status'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    charityId: json['charityId'] as int?,
    charityName: json['charityName'] as String?,
    adminId: json['adminId'] as int?,
    attachments: json['attachments'] as List<dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'location': location,
    'age': age,
    'targetAmount': targetAmount,
    'collectedAmount': collectedAmount,
    'coverImageUrl': coverImageUrl,
    'beneficiaryName': beneficiaryName,
    'endDate': endDate,
    'isFeatured': isFeatured,
    'isDeleted': isDeleted,
    'donorsCount': donorsCount,
    'categoryId': categoryId,
    'categoryName': categoryName,
    'priority': priority,
    'status': status,
    'createdAt': createdAt?.toIso8601String(),
    'charityId': charityId,
    'charityName': charityName,
    'adminId': adminId,
    'attachments': attachments,
  };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      location,
      age,
      targetAmount,
      collectedAmount,
      coverImageUrl,
      beneficiaryName,
      endDate,
      isFeatured,
      isDeleted,
      donorsCount,
      categoryId,
      categoryName,
      priority,
      status,
      createdAt,
      charityId,
      charityName,
      adminId,
      attachments,
    ];
  }
}
