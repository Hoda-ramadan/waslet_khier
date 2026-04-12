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
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: backGroundColor,
      appBar: CustomHomeViewAppbar(
        onmenuTap: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      body: HomeViewBody(),
    );
  }
}
