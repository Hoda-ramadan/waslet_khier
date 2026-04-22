import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_arrow.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_favorite_border.dart';

class Custom2AppBar extends StatelessWidget implements PreferredSizeWidget {
  const Custom2AppBar({super.key, required this.function});
  final void Function()? function;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(58, 0, 101, 1),
        statusBarIconBrightness: Brightness.light,
      ),
      leading: Center(
        child: GestureDetector(
          onTap: function,
          child: Custom_arrow(),
        ),
      ),
      title: const Center(
        child: Text(
          "تفاصيل الحالة",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      actions: const [Custom_favorite_border()],
    );
  }
}