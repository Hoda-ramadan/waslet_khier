import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintTtxt,
    required this.prefxIcon,
    required this.isSuffixIcon,
    this.controller,
    this.validator,
  });

  final String labelText;
  final String hintTtxt;
  final IconData prefxIcon;
  final bool isSuffixIcon;
  final TextEditingController? controller;

  final String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode focusNode = FocusNode();
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSuffixIcon;

    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: widget.controller,
        focusNode: focusNode,
        obscureText: isObscure,

        cursorColor: tintAppColor,

        validator:
            widget.validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
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
