import 'package:equatable/equatable.dart';

class CategoryMadel extends Equatable {
  final int? id;
  final String? name;
  final int? charityId;
  final String? iconUrl;
  final String? charityName;

  const CategoryMadel({
    this.id,
    this.name,
    this.charityId,
    this.iconUrl,
    this.charityName,
  });

  factory CategoryMadel.fromJson(Map<String, dynamic> json) {
    return CategoryMadel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      charityId: json['charityId'] as int?,
      iconUrl: json['iconUrl'] as String?,
      charityName: json['charityName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'charityId': charityId,
    'iconUrl': iconUrl,
    'charityName': charityName,
  };

  @override
  List<Object?> get props => [id, name, charityId, iconUrl, charityName];
}
