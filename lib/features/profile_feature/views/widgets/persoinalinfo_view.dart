import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_arrow.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/personinfoview_body.dart';

class PersonInfo_view extends StatelessWidget {
  const PersonInfo_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: backGroundColor,
      body: PersoninfoView_body(),
    );
  }
}

class customappbar extends StatelessWidget {
  const customappbar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        backgroundColor: backGroundColor,
        leading: Center(child: Custom_arrow()),
        title: Row(
          children: [
            const SizedBox(width: 35),
            Text(
              text,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
              ),
            ),

            if (text == "تفاصيل الجمعية") Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite, color: Colors.red, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
