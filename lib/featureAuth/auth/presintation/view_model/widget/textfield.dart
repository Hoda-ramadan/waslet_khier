import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class Textfild extends StatefulWidget {
  Textfild({
    super.key,
    required this.hint,
    required this.prefixicon,
    this.suffixicon = null,
    this.onChanged,
    this.focsNode,
  });
  final String hint;
  final IconData prefixicon;
  final IconData? suffixicon;
  Function(String)? onChanged;
  final String? focsNode;

  @override
  State<Textfild> createState() => _TextfildState();
}

class _TextfildState extends State<Textfild> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isObscure = true;
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
      child: Container(
        height: 56,
        width: double.infinity,
        color: Colors.white,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "القيمة مطلوبة";
            }
          },
          onChanged: widget.onChanged,
          style: TextStyle(),

          textAlign: TextAlign.start,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.prefixicon),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(widget.suffixicon),
            ),

            label: Text(widget.hint),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintMaxLines: 1,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    );
  }
}
