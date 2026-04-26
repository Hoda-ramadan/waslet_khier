import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';

class RememberMe extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RememberMe({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) return appcolor;
              return const Color(0xFFC3C7C5);
            }),
            side: const BorderSide(color: Color(0xFFC3C7C5)),
            value: isChecked,
            onChanged: (value) async {
              setState(() => isChecked = value!);
              final provider = context.read<AuthProvider_info>();
              if (value == true) {
                // ✅ حفظ الإيميل والباسورد
                await provider.savePassword(
                  widget.emailController.text.trim(),
                  widget.passwordController.text.trim(),
                );
              } else {
                // ✅ مسح لو شيل التيك
                await provider.clearSavedCredentials();
              }
            },
          ),
          const Text("تذكرني"),
        ],
      ),
    );
  }
}
