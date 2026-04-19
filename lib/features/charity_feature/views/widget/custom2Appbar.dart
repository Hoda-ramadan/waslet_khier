import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_arrow.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_favorite_border.dart';

class Custom2AppBar extends StatelessWidget implements PreferredSizeWidget {
  const Custom2AppBar({super.key, required this.function});
  final void Function()? function;
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appcolor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: const Color.fromRGBO(58, 0, 101, 1),
        statusBarIconBrightness: Brightness.light,
      ),
      title: Row(
        children: [
          SizedBox(),
          Container(
            width: double.infinity,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: AppBar(
                automaticallyImplyLeading: false,
                leading: Center(child: GestureDetector(
                  onTap:  function,
                  child: Custom_arrow())),
                title: Center(child: Text("تفاصيل الجمعية")),
                backgroundColor: backGroundColor,
                actions: [Custom_favorite_border()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
