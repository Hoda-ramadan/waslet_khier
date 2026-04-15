import 'package:equatable/equatable.dart';

class DonorRegister extends Equatable {
  final dynamic token;
  final String? message;
  final bool? isAuthenticated;
  final List<String>? roles;
  final String? expireDate;
  final dynamic donor;
  final dynamic admin;
  final dynamic superAdmin;

  const DonorRegister({
    this.token,
    this.message,
    this.isAuthenticated,
    this.roles,
    this.expireDate,
    this.donor,
    this.admin,
    this.superAdmin,
  });

  factory DonorRegister.fromJson(Map<String, dynamic> json) => DonorRegister(
    token: json['token'] as dynamic,
    message: json['message'] as String?,
    isAuthenticated: json['isAuthenticated'] as bool?,
    roles: json['roles'] as List<String>?,
    expireDate: json['expireDate'] as String?,
    donor: json['donor'] as dynamic,
    admin: json['admin'] as dynamic,
    superAdmin: json['superAdmin'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'message': message,
    'isAuthenticated': isAuthenticated,
    'roles': roles,
    'expireDate': expireDate,
    'donor': donor,
    'admin': admin,
    'superAdmin': superAdmin,
  };

  @override
  List<Object?> get props {
    return [
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
}
