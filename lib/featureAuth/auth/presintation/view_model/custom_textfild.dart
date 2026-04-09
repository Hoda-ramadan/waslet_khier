import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintTtxt,
    required this.prefxIcon,
    required this.isSuffixIcon,
    this.controller, // أضف "this" هنا لربطها بالخاصية أدناه
  });

  final String labelText;
  final String hintTtxt;
  final IconData prefxIcon;
  final bool isSuffixIcon;
  final TextEditingController? controller; // تعريف الـ controller هنا كـ final

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // حذفنا تعريف الـ controller من هنا لأنه سيأتي من الـ Widget (الأب)
  final FocusNode focusNode = FocusNode();
  bool isObscure = true; // اجعلها true افتراضياً إذا كانت كلمة مرور

  @override
  void initState() {
    super.initState();
    // إذا لم يكن الحقل كلمة مرور، اجعل النص ظاهراً
    isObscure = widget.isSuffixIcon;

    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // لا تحذف (dispose) للـ controller هنا لأن الأب هو المسؤول عنه
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: widget
            .controller, // نستخدم widget.controller للوصول للمتحكم الخارجي
        focusNode: focusNode,
        obscureText: isObscure,
        cursorColor: tintAppColor,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "هذا الحقل مطلوب";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintTtxt,
          prefixIcon: Icon(
            widget.prefxIcon,
            color: focusNode.hasFocus ? appcolor : Colors.grey,
          ),
          suffixIcon: widget.isSuffixIcon
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: focusNode.hasFocus ? appcolor : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey.shade100,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: appcolor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
