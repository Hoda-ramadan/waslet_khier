import 'package:flutter/material.dart';
import 'package:waslet_khier/features/cases_feature/widgets/case_detales_view_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom2Appbar.dart';

class CaseDetatlsVeiw extends StatelessWidget {
  const CaseDetatlsVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: Custom2AppBar(),
    body: CaseDetalesViewBody(),
    );
  }
}