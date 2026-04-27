import 'dart:convert';

import 'package:dio/dio.dart';
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

  // في authprovider.dart - عدّل setAuthData
  Future<void> setAuthData({
    String? token,
    DonorModel? donor,
    AdminModel? admin,
  }) async {
    if (token != null && token.isNotEmpty) {
      _token = token;
    }

    final prefs = await SharedPreferences.getInstance();
    final hasLocalChanges = prefs.getBool('hasLocalChanges') ?? false;

    // ✅ لو في تعديلات محلية، مش بنكتب فوقيها بالـ API data
    if (donor != null && !hasLocalChanges) {
      _donor = donor;
    }

    if (admin != null) _admin = admin;

    if (_token != null && _token!.isNotEmpty) {
      await prefs.setString('token', _token!);
    }

    if (_donor != null) {
      await prefs.setInt('donorId', _donor!.id);
      await prefs.setString('donorUserId', donor?.userId ?? '');
      await prefs.setString('donorFirstName', _donor!.firstName);
      await prefs.setString('donorLastName', _donor!.lastName);
      await prefs.setString('donorEmail', _donor!.email);
      await prefs.setString('donorPhone', _donor!.phoneNumber);
      await prefs.setString('donorImageUrl', _donor!.imageUrl ?? '');
    }

    if (admin != null && _admin != null) {
      await prefs.setInt('adminId', _admin!.id);
      await prefs.setString('adminUserId', _admin!.userId);
      await prefs.setInt('adminCharityId', _admin!.charityId);
      await prefs.setString('adminCharityName', _admin!.charityName);
      await prefs.setString('adminFirstName', _admin!.firstName);
      await prefs.setString('adminLastName', _admin!.lastName);
      await prefs.setString('adminEmail', _admin!.email);
      await prefs.setString('adminPhone', _admin!.phoneNumber);
      await prefs.setString('adminImageUrl', _admin!.imageUrl ?? '');
    }

    notifyListeners();
  }

  // ✅ فانكشن بتحدث البيانات محلياً بس من غير ما تتأثر بالـ login
  Future<void> updateDonorLocally(DonorModel updatedDonor) async {
    _donor = updatedDonor;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('donorUserId', updatedDonor.userId ?? '');
    await prefs.setInt('donorId', updatedDonor.id);
    await prefs.setString('donorFirstName', updatedDonor.firstName);
    await prefs.setString('donorLastName', updatedDonor.lastName);
    await prefs.setString('donorEmail', updatedDonor.email);
    await prefs.setString('donorPhone', updatedDonor.phoneNumber);
    await prefs.setString('donorImageUrl', updatedDonor.imageUrl ?? '');
    await prefs.setBool('hasLocalChanges', true); // ✅ علامة إن في تعديلات محلية
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
          userId: prefs.getString('donorUserId') ?? "",
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

    // ✅ بدل clear() امسحي الـ token بس وسيبي البيانات
    await prefs.remove('token');
    await prefs.remove('adminId');
    await prefs.remove('adminUserId');
    await prefs.remove('adminCharityId');
    await prefs.remove('adminCharityName');
    await prefs.remove('adminFirstName');
    await prefs.remove('adminLastName');
    await prefs.remove('adminEmail');
    await prefs.remove('adminPhone');
    await prefs.remove('adminImageUrl');

    // ✅ البيانات الشخصية للـ donor بتفضل محفوظة
    // donorFirstName, donorLastName, donorEmail, donorPhone, donorImageUrl

    notifyListeners();
  }

  // ✅ حفظ الباسورد للـ remember me
  Future<void> savePassword(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedEmail', email);
    await prefs.setString('savedPassword', password);
  }

  Future<Map<String, String?>> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString('savedEmail'),
      'password': prefs.getString('savedPassword'),
    };
  }

  Future<void> clearSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedEmail');
    await prefs.remove('savedPassword');
  }
 
Future<void> updateDonorOnServer(DonorModel updatedDonor) async {
  try {
    final dio = Dio();

    final formData = FormData.fromMap({
      'FirstName': updatedDonor.firstName,
      'LastName': updatedDonor.lastName,
      'Email': updatedDonor.email,
      'PhoneNumber': updatedDonor.phoneNumber,
    });

    final response = await dio.put(
      'https://erfan333555-001-site1.stempurl.com/api/Donor/${updatedDonor.id}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
      data: formData,
    );

    if (response.statusCode == 200) {
      await updateDonorLocally(updatedDonor);
    } else {
      throw Exception('فشل التحديث: ${response.statusCode}');
    }
  } catch (e) {
    rethrow;
  }
}
}
