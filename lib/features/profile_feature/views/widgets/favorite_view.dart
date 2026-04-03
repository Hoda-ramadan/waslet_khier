import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favoriteview_body.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/personinfo_view.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //   title: customappbar(text: 'المفضلة'),
      ),
      backgroundColor: backGroundColor,
      body: FavoriteView_body(),
    );
  }
}
