import 'package:collection/collection.dart';

import 'attachment.dart';

class CaseModel {
  int? id;
  String? title;
  String? description;
  int? age;
  int? targetAmount;
  int? collectedAmount;
  String? coverImageUrl;
  String? beneficiaryName;
  DateTime? endDate;
  bool? isFeatured;
  bool? isDeleted;
  int? donorsCount;
  int? categoryId;
  String? categoryName;
  String? priority;
  String? status;
  DateTime? createdAt;
  int? charityId;
  String? charityName;
  int? adminId;
  List<Attachment>? attachments;

  CaseModel({
    this.id,
    this.title,
    this.description,
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

  factory CaseModel.fromJson(Map<String, dynamic> json) => CaseModel(
    id: json['id'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    age: json['age'] as int?,
    targetAmount: json['targetAmount'] as int?,
    collectedAmount: json['collectedAmount'] as int?,
    coverImageUrl: json['coverImageUrl'] as String?,
    beneficiaryName: json['beneficiaryName'] as String?,
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
    isFeatured: json['isFeatured'] as bool?,
    isDeleted: json['isDeleted'] as bool?,
    donorsCount: json['donorsCount'] as int?,
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
    attachments: (json['attachments'] as List<dynamic>?)
        ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'age': age,
    'targetAmount': targetAmount,
    'collectedAmount': collectedAmount,
    'coverImageUrl': coverImageUrl,
    'beneficiaryName': beneficiaryName,
    'endDate': endDate?.toIso8601String(),
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
    'attachments': attachments?.map((e) => e.toJson()).toList(),
  };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CaseModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      age.hashCode ^
      targetAmount.hashCode ^
      collectedAmount.hashCode ^
      coverImageUrl.hashCode ^
      beneficiaryName.hashCode ^
      endDate.hashCode ^
      isFeatured.hashCode ^
      isDeleted.hashCode ^
      donorsCount.hashCode ^
      categoryId.hashCode ^
      categoryName.hashCode ^
      priority.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      charityId.hashCode ^
      charityName.hashCode ^
      adminId.hashCode ^
      attachments.hashCode;
}
