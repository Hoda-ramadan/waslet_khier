import 'package:collection/collection.dart';

class CharityModel {
  int? id;
  String? name;
  String? description;
  dynamic type;
  String? logoUrl;
  String? address;
  String? phoneNumber;
  String? email;
  String? coverImageUrl;
  dynamic mapUrl;
  String? facebookUrl;
  String? instagramUrl;
  String? websiteUrl;
  bool? isActive;
  int? totalProjectsCount;
  int? totalRaisedAmount;
  int? totalDonorsCount;

  CharityModel({
    this.id,
    this.name,
    this.description,
    this.type,
    this.logoUrl,
    this.address,
    this.phoneNumber,
    this.email,
    this.coverImageUrl,
    this.mapUrl,
    this.facebookUrl,
    this.instagramUrl,
    this.websiteUrl,
    this.isActive,
    this.totalProjectsCount,
    this.totalRaisedAmount,
    this.totalDonorsCount,
  });

  factory CharityModel.fromJson(Map<String, dynamic> json) => CharityModel(
    id: (json['id'] as num?)?.toInt(),
    name: json['name'] as String?,
    description: json['description'] as String?,
    type: json['type'],
    logoUrl: json['logoUrl'] as String?,
    address: json['address'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    email: json['email'] as String?,
    coverImageUrl: json['coverImageUrl'] as String?,
    mapUrl: json['mapUrl'],
    facebookUrl: json['facebookUrl'] as String?,
    instagramUrl: json['instagramUrl'] as String?,
    websiteUrl: json['websiteUrl'] as String?,
    isActive: json['isActive'] as bool?,
    totalProjectsCount: (json['totalProjectsCount'] as num?)?.toInt(), // ← fix
    totalRaisedAmount: (json['totalRaisedAmount'] as num?)?.toInt(), // ← fix
    totalDonorsCount: (json['totalDonorsCount'] as num?)?.toInt(), // ← fix
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'type': type,
    'logoUrl': logoUrl,
    'address': address,
    'phoneNumber': phoneNumber,
    'email': email,
    'coverImageUrl': coverImageUrl,
    'mapUrl': mapUrl,
    'facebookUrl': facebookUrl,
    'instagramUrl': instagramUrl,
    'websiteUrl': websiteUrl,
    'isActive': isActive,
    'totalProjectsCount': totalProjectsCount,
    'totalRaisedAmount': totalRaisedAmount,
    'totalDonorsCount': totalDonorsCount,
  };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CharityModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      type.hashCode ^
      logoUrl.hashCode ^
      address.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      coverImageUrl.hashCode ^
      mapUrl.hashCode ^
      facebookUrl.hashCode ^
      instagramUrl.hashCode ^
      websiteUrl.hashCode ^
      isActive.hashCode ^
      totalProjectsCount.hashCode ^
      totalRaisedAmount.hashCode ^
      totalDonorsCount.hashCode;
}
