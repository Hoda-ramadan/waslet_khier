import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showsnackbar(FirebaseAuthException e, BuildContext context) {
  String msg = "حدث خطأ";
  if (e.code == 'email-already-in-use') {
    msg = "الايميل مستخدم بالفعل ";
  } else if (e.code == "weak-password") {
    msg = "كلمة المرور ضعيفة";
  } else if (e.code == 'user-not-found') {
    msg = "الحساب غير موجود";
  } else if (e.code == 'wrong-password') {
    msg = "كلمة المرور غير صحيحة";
  }
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
}
