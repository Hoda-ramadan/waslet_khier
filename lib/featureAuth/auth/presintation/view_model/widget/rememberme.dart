import 'package:flutter/material.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/forget_password_view.dart';

class Remeberme extends StatelessWidget {
  const Remeberme({super.key, this.value = false, this.onChanged});
  final bool value;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 20,
        width: 343,
        child: Row(
          children: [
            Checkbox(value: value, onChanged: onChanged),
            Text("تذكرني"),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ForgetPassword();
                    },
                  ),
                );
              },
              child: Text("نسيت كلمة المرور"),
            ),
          ],
        ),
      ),
    );
  }
}
