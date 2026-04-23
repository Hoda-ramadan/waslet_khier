import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favoriteview_body.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/personinfo_view.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: backGroundColor,
      body: FavoriteView_body(),
    );
  }
}
