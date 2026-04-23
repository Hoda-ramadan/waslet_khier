import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waslet_khier/featureAuth/auth/data/models/login_response_model.dart';

class AuthProvider_info extends ChangeNotifier {
  String? _token;
  DonorModel? _donor;
  AdminModel? _admin;

  String? get token => _token;
  DonorModel? get donor => _donor;
  AdminModel? get admin => _admin;

  bool get isLoggedIn => _token != null && _token!.isNotEmpty;

  Future<void> setAuthData({
    String? token,
    DonorModel? donor,
    AdminModel? admin,
  }) async {
    if (token == null || token.isEmpty) return;

    _token = token;
    _donor = donor;
    _admin = admin;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    // save donor
    if (donor != null) {
      await prefs.setInt('donorId', donor.id);
      await prefs.setString('donorFirstName', donor.firstName);
      await prefs.setString('donorLastName', donor.lastName);
      await prefs.setString('donorEmail', donor.email);
      await prefs.setString('donorPhone', donor.phoneNumber);
      await prefs.setString('donorImageUrl', donor.imageUrl ?? '');
    }

    // save admin
    if (admin != null) {
      await prefs.setInt('adminId', admin.id);
      await prefs.setString('adminUserId', admin.userId);
      await prefs.setInt('adminCharityId', admin.charityId);
      await prefs.setString('adminCharityName', admin.charityName);
      await prefs.setString('adminFirstName', admin.firstName);
      await prefs.setString('adminLastName', admin.lastName);
      await prefs.setString('adminEmail', admin.email);
      await prefs.setString('adminPhone', admin.phoneNumber);
      await prefs.setString('adminImageUrl', admin.imageUrl ?? '');
    }

    notifyListeners();
  }

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');

    if (savedToken != null && savedToken.isNotEmpty) {
      _token = savedToken;

      // restore donor
      final firstName = prefs.getString('donorFirstName');
      if (firstName != null && firstName.isNotEmpty) {
        _donor = DonorModel(
          id: prefs.getInt('donorId') ?? 0,
          firstName: firstName,
          lastName: prefs.getString('donorLastName') ?? '',
          email: prefs.getString('donorEmail') ?? '',
          phoneNumber: prefs.getString('donorPhone') ?? '',
          imageUrl: prefs.getString('donorImageUrl'),
        );
      }

      // restore admin
      final adminCharityId = prefs.getInt('adminCharityId');
      if (adminCharityId != null && adminCharityId != 0) {
        _admin = AdminModel(
          id: prefs.getInt('adminId') ?? 0,
          userId: prefs.getString('adminUserId') ?? '',
          charityId: adminCharityId,
          charityName: prefs.getString('adminCharityName') ?? '',
          firstName: prefs.getString('adminFirstName') ?? '',
          lastName: prefs.getString('adminLastName') ?? '',
          email: prefs.getString('adminEmail') ?? '',
          phoneNumber: prefs.getString('adminPhone') ?? '',
          imageUrl: prefs.getString('adminImageUrl'),
        );
      }
    }

    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _donor = null;
    _admin = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
