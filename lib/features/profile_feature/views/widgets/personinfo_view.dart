import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_arrow.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/personinfoview_body.dart';

class PersonInfo_view extends StatelessWidget {
  const PersonInfo_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: customappbar(), automaticallyImplyLeading: false),
      backgroundColor: backGroundColor,
      body: PersoninfoView_body(),
    );
  }
}

class customappbar extends StatelessWidget {
  const customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        backgroundColor: backGroundColor,
        leading: Center(child: Custom_arrow()),
        title: Center(child: Text("المعلومات الشخصية")),
      ),
    );
  }
}
