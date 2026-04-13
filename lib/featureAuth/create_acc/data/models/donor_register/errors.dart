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
    email: (json['Email'] as List?)?.map((e) => e.toString()).toList(),

    phone: (json['Phone'] as List?)?.map((e) => e.toString()).toList(),

    lastName: (json['LastName'] as List?)?.map((e) => e.toString()).toList(),

    password: (json['Password'] as List?)?.map((e) => e.toString()).toList(),

    firstName: (json['FirstName'] as List?)?.map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    'Email': email,
    'Phone': phone,
    'LastName': lastName,
    'Password': password,
    'FirstName': firstName,
  };

  @override
  List<Object?> get props => [email, phone, lastName, password, firstName];
}
