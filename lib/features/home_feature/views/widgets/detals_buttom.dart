import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';

class DetalsButtom extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final CaseModel casee ;
  const DetalsButtom({
    super.key,
    this.width = 118,
    this.height = 36,
    required this.fontSize, required this.casee,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
                          '/cases/case_detals_view',
                          extra: casee,
                        );
      },
      child: Container(
        width: width,
        height: height,

        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFFAF4FE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: appcolor, width: 1),
        ),
        child: Text(
          'التفاصيل',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: appcolor,
            fontSize: fontSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
