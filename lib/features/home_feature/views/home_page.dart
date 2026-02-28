import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/custom_home_view_appbar.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/home_view_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
     return const Scaffold(
     backgroundColor: backGroundColor,
     appBar:  CustomHomeViewAppbar(),
     body: HomeViewBody(),

    );
  }
}