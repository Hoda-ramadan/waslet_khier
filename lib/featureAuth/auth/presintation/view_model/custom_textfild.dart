import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintTtxt,
    required this.prefxIcon,
    required this.isSuffixIcon,
  });
  final String labelText;
  final String hintTtxt;
  final IconData prefxIcon;
  final bool isSuffixIcon;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isObscure,
        cursorColor: tintAppColor,

        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required field";
          }
          if (value.length < 6) {
            return "Minimum 6 characters";
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
                    isObscure ? Icons.visibility : Icons.visibility_off,
                    color: focusNode.hasFocus ? appcolor : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null, // If false, show nothing
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
