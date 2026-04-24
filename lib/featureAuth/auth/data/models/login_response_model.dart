import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final dynamic token;
  final String? message;
  final bool? isAuthenticated;
  final List<String>? roles;
  final String? expireDate;
  final DonorModel? donor;
  final AdminModel? admin;
  final dynamic superAdmin;

  const LoginResponse({
    this.token,
    this.message,
    this.isAuthenticated,
    this.roles,
    this.expireDate,
    this.donor,
    this.admin,
    this.superAdmin,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json['token'],
    message: json['message']?.toString(),
    isAuthenticated: json['isAuthenticated'] as bool?,
    roles: (json['roles'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    expireDate: json['expireDate']?.toString(),
    donor: json['donor'] != null ? DonorModel.fromJson(json['donor']) : null,
    admin: json['admin'] != null ? AdminModel.fromJson(json['admin']) : null,
    superAdmin: json['superAdmin'],
  );

  @override
  List<Object?> get props => [
    token,
    message,
    isAuthenticated,
    roles,
    expireDate,
    donor,
    admin,
    superAdmin,
  ];
}

class DonorModel {
  final int id;
  final String? userId; // ✅ ضيفي userId
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? imageUrl;

  DonorModel({
    required this.id,
    this.userId, // ✅
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.imageUrl,
  });

  factory DonorModel.fromJson(Map<String, dynamic> json) => DonorModel(
    id: json['id'] ?? 0,
    userId: json['userId']?.toString(), // ✅
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    email: json['email'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    imageUrl: json['imageUrl'],
  );

  String get fullName => '$firstName $lastName';
}

class AdminModel {
  final int id;
  final String? imageUrl;
  final String userId;
  final int charityId;
  final String charityName;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  AdminModel({
    required this.id,
    this.imageUrl,
    required this.userId,
    required this.charityId,
    required this.charityName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    id: json['id'] ?? 0,
    imageUrl: json['imageUrl'],
    userId: json['userId'] ?? '',
    charityId: json['charityId'] ?? 0,
    charityName: json['charityName'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    email: json['email'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
  );

  String get fullName => '$firstName $lastName';
}
