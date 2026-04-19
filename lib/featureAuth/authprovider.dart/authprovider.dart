import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonorModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? imageUrl;

  DonorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.imageUrl,
  });

  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }

  String get fullName => '$firstName $lastName';
}

class AuthProvider_info extends ChangeNotifier {
  String? _token;
  DonorModel? _donor;

  String? get token => _token;
  DonorModel? get donor => _donor;

  // ✅ fix 1: check token is not empty string
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;

  // ✅ fix 2: renamed and returns Future
  Future<void> setAuthData({String? token, dynamic donor}) async {
    // ✅ fix 3: don't save if token is null or empty
    if (token == null || token.isEmpty) return;

    _token = token;

    if (donor != null && donor is Map<String, dynamic>) {
      _donor = DonorModel.fromJson(donor);
    } else if (donor is DonorModel) {
      _donor = donor;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('donorFirstName', _donor?.firstName ?? '');
    await prefs.setString('donorLastName', _donor?.lastName ?? '');
    await prefs.setString('donorEmail', _donor?.email ?? '');
    await prefs.setString('donorPhone', _donor?.phoneNumber ?? '');

    notifyListeners();
  }

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');

    // ✅ fix 4: only restore if token actually has value
    if (savedToken != null && savedToken.isNotEmpty) {
      _token = savedToken;
      final firstName = prefs.getString('donorFirstName');
      if (firstName != null && firstName.isNotEmpty) {
        _donor = DonorModel(
          id: 0,
          firstName: firstName,
          lastName: prefs.getString('donorLastName') ?? '',
          email: prefs.getString('donorEmail') ?? '',
          phoneNumber: prefs.getString('donorPhone') ?? '',
        );
      }
    }

    notifyListeners();
  }

  // ✅ fix 5: returns Future<void> not void
  Future<void> logout() async {
    _token = null;
    _donor = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}