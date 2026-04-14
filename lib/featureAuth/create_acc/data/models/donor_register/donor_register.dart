import 'package:equatable/equatable.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/models/donor_register/errors.dart';

class DonorRegister extends Equatable {
  final String? token;
  final String? message;
  final bool? isAuthenticated;
  final List<String>? roles;
  // للأخطاء
  final int? status;
  final Errors? errors;

  const DonorRegister({
    this.token,
    this.message,
    this.isAuthenticated,
    this.roles,
    this.status,
    this.errors,
  });

  factory DonorRegister.fromJson(Map<String, dynamic> json) => DonorRegister(
    token: json['token'] as String?,
    message: json['message'] as String?,
    isAuthenticated: json['isAuthenticated'] as bool?,
    roles: (json['roles'] as List?)?.map((e) => e.toString()).toList(),
    status: json['status'] as int?,
    errors: json['errors'] == null
        ? null
        : Errors.fromJson(json['errors'] as Map<String, dynamic>),
  );

  @override
  List<Object?> get props => [
    token,
    message,
    isAuthenticated,
    roles,
    status,
    errors,
  ];
}
