import 'package:equatable/equatable.dart';

class FavoriteModel extends Equatable {
  final int? id;
  final int? donorId;
  final String? donorName;
  final int? caseId;
  final String? caseTitle;
  final dynamic coverImageUrl;

  const FavoriteModel({
    this.id,
    this.donorId,
    this.donorName,
    this.caseId,
    this.caseTitle,
    this.coverImageUrl,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    id: json['id'] as int?,
    donorId: json['donorId'] as int?,
    donorName: json['donorName'] as String?,
    caseId: json['caseId'] as int?,
    caseTitle: json['caseTitle'] as String?,
    coverImageUrl: json['coverImageUrl'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'donorId': donorId,
    'donorName': donorName,
    'caseId': caseId,
    'caseTitle': caseTitle,
    'coverImageUrl': coverImageUrl,
  };

  @override
  List<Object?> get props {
    return [id, donorId, donorName, caseId, caseTitle, coverImageUrl];
  }
}
