import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/forget_password_view.dart';
import 'package:waslet_khier/featureAuth/create_acc/create_acc_view.dart';

class checkhavingAcc extends StatelessWidget {
  const checkhavingAcc({
    super.key,
    required this.text1,
    required this.text2,
    required this.textcolor1,
    required this.textcolor2,
    required this.path,
  });
  final String text1, text2, path;
  final Color textcolor1, textcolor2;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      width: 343,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push("/profile/logout$path");
              },
              child: Text(
                text2,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFF8A3D),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
