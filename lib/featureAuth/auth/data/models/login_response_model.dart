import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final dynamic token;
  final String? message;
  final bool? isAuthenticated;
  final List<String>? roles;
  final String? expireDate;
  final dynamic donor;
  final dynamic admin;
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
    donor: json['donor'],
    admin: json['admin'],
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
