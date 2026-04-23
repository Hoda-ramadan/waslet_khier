import 'package:flutter/material.dart';
import 'package:waslet_khier/core/class/assets.dart';

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });

      return Dialog(
        backgroundColor: const Color.fromARGB(0, 249, 235, 235),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Image.asset(
                  Assets.done_acc,
                  width: 120,
                  height: 120,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'تم إنشاء الحساب بنجاح',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}
