import 'package:flutter/material.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/forget_password_view.dart';

class checkhavingAcc extends StatelessWidget {
  const checkhavingAcc({super.key});

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
              "ليس لديك حساب ؟ ",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("CreateAccView()");
              },
              child: Text(
                "تسجيل حساب",
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
