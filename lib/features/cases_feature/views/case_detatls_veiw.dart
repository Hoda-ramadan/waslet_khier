import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/cases_feature/widgets/case_detales_view_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom2Appbar.dart';

class CaseDetatlsVeiw extends StatelessWidget {
  const CaseDetatlsVeiw({super.key, required this.casee});
  final CaseModel casee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom2AppBar(),
      body: CaseDetalesViewBody(casee: casee),
    );
  }
}
