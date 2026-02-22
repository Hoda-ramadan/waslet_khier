import 'package:flutter/material.dart';

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
            GestureDetector(child: Text("نسيت كلمة المرور")),
          ],
        ),
      ),
    );
  }
}
