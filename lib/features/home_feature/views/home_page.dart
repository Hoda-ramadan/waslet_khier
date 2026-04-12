import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/views/Custom_drawer.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/custom_home_view_appbar.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/home_view_body.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return const Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomHomeViewAppbar(),
=======
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: backGroundColor,
      appBar: CustomHomeViewAppbar(
        onmenuTap: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
>>>>>>> 3349deb558fe0c7bec95c97afc532f391854f15c
      body: HomeViewBody(),
    );
  }
}
