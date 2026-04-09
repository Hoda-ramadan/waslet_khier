import 'package:equatable/equatable.dart';

class Errors extends Equatable {
  final List<String>? email;
  final List<String>? phone;
  final List<String>? lastName;
  final List<String>? password;
  final List<String>? firstName;

  const Errors({
    this.email,
    this.phone,
    this.lastName,
    this.password,
    this.firstName,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    email: json['Email'] as List<String>?,
    phone: json['Phone'] as List<String>?,
    lastName: json['LastName'] as List<String>?,
    password: json['Password'] as List<String>?,
    firstName: json['FirstName'] as List<String>?,
  );

  Map<String, dynamic> toJson() => {
    'Email': email,
    'Phone': phone,
    'LastName': lastName,
    'Password': password,
    'FirstName': firstName,
  };

  @override
  List<Object?> get props {
    return [email, phone, lastName, password, firstName];
  }
}
