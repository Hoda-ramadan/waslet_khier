import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/cases_feature/widgets/detals_view_case_image.dart';
import 'package:waslet_khier/features/cases_feature/widgets/states_taps.dart';
import 'package:waslet_khier/features/cases_feature/widgets/stause_row.dart';
import 'package:waslet_khier/features/cases_feature/widgets/title_text.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_cubit.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_item.dart';

import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class StatesCardGridViewOfcharity extends StatelessWidget {
  StatesCardGridViewOfcharity({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: SizedBox(width: 140, child: Container()),
          );
        },
      ),
    );
  }
}
