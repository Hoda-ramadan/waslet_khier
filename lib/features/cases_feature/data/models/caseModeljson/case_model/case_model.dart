import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'attachment.dart';

class CaseModel {
  int? id;
  String? title;

  String? description;
  int? age;
  double? targetAmount;
  double? collectedAmount;
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

  factory CaseModel.fromJson(Map<String, dynamic> json) {
  try {
    return CaseModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      age: (json['age'] as num?)?.toInt(),
      targetAmount: (json['targetAmount'] as num?)?.toDouble(),
      collectedAmount: (json['collectedAmount'] as num?)?.toDouble(),
      coverImageUrl: json['coverImageUrl'] as String?,
      beneficiaryName: json['beneficiaryName'] as String?,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isFeatured: json['isFeatured'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      donorsCount: (json['donorsCount'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      priority: json['priority'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      charityId: (json['charityId'] as num?)?.toInt(),
      charityName: json['charityName'] as String?,
      adminId: (json['adminId'] as num?)?.toInt(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  } catch (e, stack) {
    // print every field value so we can see which one fails
    debugPrint('=== CaseModel.fromJson ERROR ===');
    debugPrint('json: $json');
    debugPrint('error: $e');
    debugPrint('stack: $stack');
    rethrow;
  }
}

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
