import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';

class DonateNowButtom extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final CaseModel caseModel;
  const DonateNowButtom({
    super.key,
    this.width = 100,
    this.height = 36,
    required this.fontSize,
    required this.caseModel,
  });

  @override
  Widget build(BuildContext context) {
   if ((caseModel.collectedAmount ?? 0) < (caseModel.targetAmount ?? 0)) {
    return GestureDetector(
      onTap: () {
        context.push("/cases/donation", extra: caseModel);
      },
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: orangcolor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'تبرع الآن',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
  
  else {
   return GestureDetector(
      onTap: () {
      },
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(217, 50, 159, 79),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
      'اكتملت الحاله',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize-2,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
  }
}
