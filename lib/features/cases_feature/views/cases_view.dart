import 'package:flutter/material.dart';
import 'package:waslet_khier/features/cases_feature/widgets/cases_view_body.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customAppbar.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';

class CasesView extends StatelessWidget {
  const CasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(),
        Expanded(child: CasesViewBody()),
      ],
    );
  }
}
